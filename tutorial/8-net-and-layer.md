### Net and Layer
```
// tools/caffe.cpp
shared_ptr<caffe::Solver<float> >
      solver(caffe::SolverRegistry<float>::CreateSolver(solver_param));
```
These codes define CreateSolver.  
```
// include/caffe/solver_factory.cpp
// Get a solver using a SolverParameter.
  static Solver<Dtype>* CreateSolver(const SolverParameter& param) {
    // Type of solver, such as SGD.
    const string& type = param.type();
    // typedef std::map<string, Creator> CreatorRegistry;
    // Type of Creator is function pointer
    CreatorRegistry& registry = Registry();
    CHECK_EQ(registry.count(type), 1) << "Unknown solver type: " << type
        << " (known types: " << SolverTypeListString() << ")";
    // typedef Solver<Dtype>* (*Creator)(const SolverParameter&);
    // return Solver*(param)
    return registry[type](param);
  }
```
The type of the return value of this function is Solver*(param), which is a pointer to function REGISTER_SOLVER_CLASS(SGD).  
```
// src/caffe/solvers/sgd_solver.cpp
REGISTER_SOLVER_CLASS(SGD);
```
```
// include/caffe/solver_factory.hpp
#define REGISTER_SOLVER_CLASS(type)                                            \
  template <typename Dtype>                                                    \
  Solver<Dtype>* Creator_##type##Solver(                                       \
      const SolverParameter& param)                                            \
  {                                                                            \
    return new type##Solver<Dtype>(param);                                     \
  }                                                                            \
  REGISTER_SOLVER_CREATOR(type, Creator_##type##Solver)

}  // namespace caffe
```
```
// include/caffe/sgd_solver.hpp
explicit SGDSolver(const SolverParameter& param)
      : Solver<Dtype>(param) { PreSolve(); }
```
This function will new SGDSolver, which is inherits from its parent class, _i.e_ Solver. Therefor, the constructor of Solver is called.  
```
// src/caffe/solver.cpp
Solver<Dtype>::Solver(const SolverParameter& param)
    : net_(), callbacks_(), requested_early_exit_(false) {
  Init(param);
}
```
The constructor of Solver call Init() to initialize the networks.  
```
// src/caffe/solvers.cpp
void Solver<Dtype>::Init(const SolverParameter& param) {
  LOG_IF(INFO, Caffe::root_solver()) << "Initializing solver from parameters: "
    << std::endl << param.DebugString();
  param_ = param;
  CHECK_GE(param_.average_loss(), 1) << "average_loss should be non-negative.";
  CheckSnapshotWritePermissions();
  if (param_.random_seed() >= 0) {
    Caffe::set_random_seed(param_.random_seed() + Caffe::solver_rank());
  }
  // Scaffolding code
  InitTrainNet();
  InitTestNets();
  if (Caffe::root_solver()) {
    LOG(INFO) << "Solver scaffolding done.";
  }
  iter_ = 0;
  current_step_ = 0;
}
```
InitTrainNet() will construct the training network.  
```
// src/caffe/solver.cpp
void Solver<Dtype>::InitTrainNet() {
  const int num_train_nets = param_.has_net() + param_.has_net_param() +
      param_.has_train_net() + param_.has_train_net_param();
  const string field_names = "net, net_param, train_net, train_net_param";
  CHECK_GE(num_train_nets, 1) << "SolverParameter must specify a train net "
      << "using one of these fields: " << field_names;
  CHECK_LE(num_train_nets, 1) << "SolverParameter must not contain more than "
      << "one of these fields specifying a train_net: " << field_names;
  NetParameter net_param;
  if (param_.has_train_net_param()) {
    LOG_IF(INFO, Caffe::root_solver())
        << "Creating training net specified in train_net_param.";
    net_param.CopyFrom(param_.train_net_param());
  } else if (param_.has_train_net()) {
    LOG_IF(INFO, Caffe::root_solver())
        << "Creating training net from train_net file: " << param_.train_net();
    ReadNetParamsFromTextFileOrDie(param_.train_net(), &net_param);
  }
  if (param_.has_net_param()) {
    LOG_IF(INFO, Caffe::root_solver())
        << "Creating training net specified in net_param.";
    net_param.CopyFrom(param_.net_param());
  }
  if (param_.has_net()) {
    LOG_IF(INFO, Caffe::root_solver())
        << "Creating training net from net file: " << param_.net();
    ReadNetParamsFromTextFileOrDie(param_.net(), &net_param);
  }
  // Set the correct NetState.  We start with the solver defaults (lowest
  // precedence); then, merge in any NetState specified by the net_param itself;
  // finally, merge in any NetState specified by the train_state (highest
  // precedence).
  NetState net_state;
  net_state.set_phase(TRAIN);
  net_state.MergeFrom(net_param.state());
  net_state.MergeFrom(param_.train_state());
  net_param.mutable_state()->CopyFrom(net_state);
  net_.reset(new Net<Dtype>(net_param));
  for (int w_idx = 0; w_idx < param_.weights_size(); ++w_idx) {
    LoadNetWeights(net_, param_.weights(w_idx));
  }
}
```
Set basic parameter and new a network by `  net_.reset(new Net<Dtype>(net_param))`.  
```
// src/caffe.net.cpp
Net<Dtype>::Net(const NetParameter& param) {
  Init(param);
}
```
The constructor of Net is called.  
```
// src/caffe/net.cpp
void Net<Dtype>::Init(const NetParameter& in_param) {
...
layers_.push_back(LayerRegistry<Dtype>::CreateLayer(layer_param)); // create a layer and assign a value
...
layers_[layer_id]->SetUp(bottom_vecs_[layer_id], top_vecs_[layer_id]);
...
}
```
```
// include/caffe/layer_factory.hpp
// Get a layer using a LayerParameter.
  static shared_ptr<Layer<Dtype> > CreateLayer(const LayerParameter& param) {
    if (Caffe::root_solver()) {
      LOG(INFO) << "Creating layer " << param.name();
    }
    const string& type = param.type();
    CreatorRegistry& registry = Registry();
    CHECK_EQ(registry.count(type), 1) << "Unknown layer type: " << type
        << " (known types: " << LayerTypeListString() << ")";
    return registry[type](param);
  }
```
```
// src/caffe/layers/data_layer.cpp
REGISTER_LAYER_CLASS(Data);
```
```
DataLayer<Dtype>::DataLayer(const LayerParameter& param)
  : BasePrefetchingDataLayer<Dtype>(param),
    offset_() {
  db_.reset(db::GetDB(param.data_param().backend()));
  db_->Open(param.data_param().source(), db::READ);
  cursor_.reset(db_->NewCursor());
}
```
This operations is similar with Solver. Initialization is implemented after above opeartions.  
```
// src/caffe/net.cpp
layers_[layer_id]->SetUp(bottom_vecs_[layer_id], top_vecs_[layer_id]);
```
```
// include/caffe/layer.hpp
void SetUp(const vector<Blob<Dtype>*>& bottom,
      const vector<Blob<Dtype>*>& top) {
    CheckBlobCounts(bottom, top);
    LayerSetUp(bottom, top); // Set shape and initialize randomly
    Reshape(bottom, top); 
    SetLossWeights(top);
  }
```
After that, a network is initialized.  

### Reference
* https://blog.csdn.net/gaoenyang760525/article/details/72874816
