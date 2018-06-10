# SwiftCiphers
## Commands
### Functions:
* ALL FUNCTIONS RETURN STRINGS
* Decrypt.caesarCipher RETURNS A STRING WITH ALL POSSIBLE VALUES OF THE CAESAR CIPHER

* `func Encrypt.morse(str: String) -> String`
* `func Encrypt.caesarCipher(str: String, shift: Int) -> String`
* `func Encrypt.rot1(str: String) -> String`
* `func Encrypt.rot13(str: String) -> String`
* `func Encrypt.base64(str: String) -> String`

* `func Decrypt.morse(str: String) -> String`
* `func Decrypt.caesarCipher(str: String) -> String`
* `func Decrypt.rot1(str: String) -> String`
* `func Decrypt.rot13(str: String) -> String`
* `func Decrypt.base64(str: String) -> String`

#### MORSE FORMAT:
* Every letter is split with a " "
* Every word is split with a " / "
*If an unknown character is used, it will return a "?" in place of the character


## Example
```
let str: String = Encrypt.ROT1(str: "Hello, World!")
print("Ecrypted: " + str)
print("Decrypted: " + Decrypt.ROT1(str: s!))
```
### output
```
Encrypted: Ifmmp, xpsme!
Decyrpted: Hello, world!
```
