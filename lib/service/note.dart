class Note {
  String cardNumber;
  String cvv;
  String expiryMonth;
  String expiryYear;
  String name;
  String address;
  String phoneNumber;

  Note(this.cardNumber, this.cvv, this.expiryMonth, this.expiryYear, this.name,
      this.address, this.phoneNumber);

  String get cardNumber1 => cardNumber;

  String get cvv1 => cvv;

  String get expiryMonth1 => expiryMonth;

  String get expiryYear1 => expiryYear;

  String get name1 => name;

  String get address1 => address;

  String get phoneNumber1 => phoneNumber;


  set cardNumber1(String newCardNumber) {
    this.cardNumber = newCardNumber;
  }

  set cvv1(String newCvv) {
    this.cvv = newCvv;
  }

  set expiryMonth1(String newExpiryMonth) {
    this.expiryMonth = newExpiryMonth;
  }

  set expiryYear1(String newExpiryYear) {
    this.expiryYear = newExpiryYear;
  }
  set name1(String newName) {
    this.name = newName;
  }
  set address1(String newAddress) {
    this.address = newAddress;
  }
  set phoneNumber1(String newPhoneNumber) {
    this.phoneNumber = newPhoneNumber;
  }
}