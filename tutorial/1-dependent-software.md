### 1. Protocol Buffer
protobuffer is a mixed language data standard in Google.  
This is an example in `1_protobuffer`:  
1. First, we write a file named as `addressbook.proto` as follows:  
```
syntax= "proto2";
package tutorial;
message Person {
  required string name = 1;
  required int32 id = 2;
  optional string email = 3;
  enum PhoneType {
    MOBILE = 0;
    HOME = 1;
    WORK = 2;
  }
  message PhoneNumber {
    required string number = 1;
    optional PhoneType type = 2 [default = HOME];
  }
  repeated PhoneNumber phone = 4;
}
message AddressBook {
  repeated Person person = 1;
}
```  
2. Then, we can compile this file:  
`protoc -I=./ --cpp_out=./ ./addressbook.proto`.  
After we run above command, we can get `addressbook.pb.h` and `addressbook.pb.cc`. In `addressbook.pb.h`, there exists many inference as follows:  
```
// required string name = 1;
inline bool has_name() const;
inline void clear_name();
static const int kNameFieldNumber = 1;
inline const ::std::string& name() const;
inline void set_name(const ::std::string& value);
inline void set_name(const char* value);
inline void set_name(const char* value, size_t size);
inline ::std::string* mutable_name();
inline ::std::string* release_name();
inline void set_allocated_name(::std::string* name);

// required int32 id = 2;
inline bool has_id() const;
inline void clear_id();
static const int kIdFieldNumber = 2;
inline ::google::protobuf::int32 id() const;
inline void set_id(::google::protobuf::int32 value);

// optional string email = 3;
inline bool has_email() const;
inline void clear_email();
static const int kEmailFieldNumber = 3;
inline const ::std::string& email() const;
inline void set_email(const ::std::string& value);
inline void set_email(const char* value);
inline void set_email(const char* value, size_t size);
inline ::std::string* mutable_email();
inline ::std::string* release_email();
inline void set_allocated_email(::std::string* email);

// repeated .tutorial.Person.PhoneNumber phone = 4;
inline int phone_size() const;
inline void clear_phone();
static const int kPhoneFieldNumber = 4;
inline const ::tutorial::Person_PhoneNumber& phone(int index) const;
inline ::tutorial::Person_PhoneNumber* mutable_phone(int index);
inline ::tutorial::Person_PhoneNumber* add_phone();
inline const ::google::protobuf::RepeatedPtrField< ::tutorial::Person_PhoneNumber >&
    phone() const;
inline ::google::protobuf::RepeatedPtrField< ::tutorial::Person_PhoneNumber >*
    mutable_phone();

// repeated .tutorial.Person person = 1;
inline int person_size() const;
inline void clear_person();
static const int kPersonFieldNumber = 1;
inline const ::tutorial::Person& person(int index) const;
inline ::tutorial::Person* mutable_person(int index);
inline ::tutorial::Person* add_person();
inline const ::google::protobuf::RepeatedPtrField< ::tutorial::Person >&
    person() const;
inline ::google::protobuf::RepeatedPtrField< ::tutorial::Person >*
    mutable_person();

```
which is for each componets in `addressbook.proto`.  
3. Next, we can write two cpp to use the this `addressbook`:  
```
\\writeMain.cpp
#include <iostream>
#include <fstream>
#include <string>
#include "addressbook.pb.h"
using namespace std;
// This function fills in a Person message based on user input.
void PromptForAddress(tutorial::Person* person) {
  cout << "Enter person ID number: ";
  int id;
  cin >> id;
  person->set_id(id);
  cin.ignore(256, '\n');
  cout << "Enter name: ";
  getline(cin, *person->mutable_name());
  cout << "Enter email address (blank for none): ";
  string email;
  getline(cin, email);
  if (!email.empty()) {
    person->set_email(email);
  }
  while (true) {
    cout << "Enter a phone number (or leave blank to finish): ";
    string number;
    getline(cin, number);
    if (number.empty()) {
      break;
    }
    tutorial::Person::PhoneNumber* phone_number = person->add_phone();
    phone_number->set_number(number);
    cout << "Is this a mobile, home, or work phone? ";
    string type;
    getline(cin, type);
    if (type == "mobile") {
      phone_number->set_type(tutorial::Person::MOBILE);
    } else if (type == "home") {
      phone_number->set_type(tutorial::Person::HOME);
    } else if (type == "work") {
      phone_number->set_type(tutorial::Person::WORK);
    } else {
      cout << "Unknown phone type.  Using default." << endl;
    }
  }
}
// Main function:  Reads the entire address book from a file,
//   adds one person based on user input, then writes it back out to the same
//   file.
int main(int argc, char* argv[]) {
  // Verify that the version of the library that we linked against is
  // compatible with the version of the headers we compiled against.
  GOOGLE_PROTOBUF_VERIFY_VERSION;
  if (argc != 2) {
    cerr << "Usage:  " << argv[0] << " ADDRESS_BOOK_FILE" << endl;
    return -1;
  }
  tutorial::AddressBook address_book;
  {
    // Read the existing address book.
    fstream input(argv[1], ios::in | ios::binary);
    if (!input) {
      cout << argv[1] << ": File not found.  Creating a new file." << endl;
    } else if (!address_book.ParseFromIstream(&input)) {
      cerr << "Failed to parse address book." << endl;
      return -1;
    }
  }
  // Add an address.
  PromptForAddress(address_book.add_person());
  {
    // Write the new address book back to disk.
    fstream output(argv[1], ios::out | ios::trunc | ios::binary);
    if (!address_book.SerializeToOstream(&output)) {
      cerr << "Failed to write address book." << endl;
      return -1;
    }
  }
  // Optional:  Delete all global objects allocated by libprotobuf.
  google::protobuf::ShutdownProtobufLibrary();
  return 0;
}
```  
Then, compile `writeMain.cpp` by   
`g++ -o write addressbook.pb.cc writeMain.cpp -lprotobuf`.  
```
\\ readMain.cpp
#include <iostream>
#include <fstream>
#include <string>
#include "addressbook.pb.h"
using namespace std;
// Iterates though all people in the AddressBook and prints info about them.
void ListPeople(const tutorial::AddressBook& address_book) {
  for (int i = 0; i < address_book.person_size(); i++) {
    const tutorial::Person& person = address_book.person(i);
    cout << "Person ID: " << person.id() << endl;
    cout << "  Name: " << person.name() << endl;
    if (person.has_email()) {
      cout << "  E-mail address: " << person.email() << endl;
    }
    for (int j = 0; j < person.phone_size(); j++) {
      const tutorial::Person::PhoneNumber& phone_number = person.phone(j);
      switch (phone_number.type()) {
        case tutorial::Person::MOBILE:
          cout << "  Mobile phone #: ";
          break;
        case tutorial::Person::HOME:
          cout << "  Home phone #: ";
          break;
        case tutorial::Person::WORK:
          cout << "  Work phone #: ";
          break;
      }
      cout << phone_number.number() << endl;
    }
  }
}
// Main function:  Reads the entire address book from a file and prints all
//   the information inside.
int main(int argc, char* argv[]) {
  // Verify that the version of the library that we linked against is
  // compatible with the version of the headers we compiled against.
  GOOGLE_PROTOBUF_VERIFY_VERSION;
  if (argc != 2) {
    cerr << "Usage:  " << argv[0] << " ADDRESS_BOOK_FILE" << endl;
    return -1;
  }
  tutorial::AddressBook address_book;
  {
    // Read the existing address book.
    fstream input(argv[1], ios::in | ios::binary);
    if (!address_book.ParseFromIstream(&input)) {
      cerr << "Failed to parse address book." << endl;
      return -1;
    }
  }
  ListPeople(address_book);
  // Optional:  Delete all global objects allocated by libprotobuf.
  google::protobuf::ShutdownProtobufLibrary();
  return 0;
}
```  
Then, compile `readMain.cpp` by   
`g++ -o read addressbook.pb.cc readMain.cpp -lprotobuf`.  
4. we can run the results `write` and `read` to test.  
```
➜  1-protobuffer git:(master) ✗ ./write Address
Address: File not found.  Creating a new file.
Enter person ID number: 1
Enter name: Jinming Su
Enter email address (blank for none): sujm@sujm.cn
Enter a phone number (or leave blank to finish): 188xxxxxxxx
Is this a mobile, home, or work phone? mobile
Enter a phone number (or leave blank to finish): 
➜  1-protobuffer git:(master) ✗ ./read Address
Person ID: 1
  Name: Jinming Su
  E-mail address: sujm@sujm.cn
  Mobile phone #: 188xxxxxxxx
```
