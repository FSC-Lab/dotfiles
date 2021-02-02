# FSC C++ Style Guide

## Using formatters

Using a formatter is **encouraged**! You are welcome to install a conformant formatter and ignore the rest of this article. 

The recommended formatter is `clang-format`. Install it by
```
sudo apt-get install clang-format
```

Apply formatting to a document and display it on the console with
```
clang-format ./path/to/hello_world.cpp
```

else format the document in place with the `-i` flag
```
clang-format -i ./path/to/hello_world.cpp
```

### Clang Format for VSCode
If you are using VSCode (highly recommended), install the [clang-format extension](https://marketplace.visualstudio.com/items?itemName=xaver.clang-format) by searching for it in the extensions tab of VSCode and installing.

Lastly, edit VScode settings by navigating to **File**-**Preferences**-**Settings**, then search for `C_Cpp.formatting` in the search bar. In the dropdown menu for this option, select `ClangFormat`.

*voila*, you can now format your current document with `Ctrl-Shift-I`

### Clang Format configuration
Formatting styles can be fine tuned with a `.clang-format` file at your C++ project root or in the `$HOME` directory. A bare bones recommendation for `.clang-format` file is
```
---
BasedOnStyle: Google
---
Language: Cpp
ColumnLimit: 120
AlignTrailingComments: true
```
## Coding Style

You are expected to conform to the [Google C++ Style Guide](https://google.github.io/styleguide/cppguide.html). The following provides a visual guide to our decisions to resolve the most debated stylistic conflicts.

### Column width

1. **Try** to stay within 80 characters per lines, but do not exceed 120 characters per line in all cases.

### Naming

1. Variables are lower case with words separated by an underscore

    <table>
    <tr>
    <td style="width: 400px;"> <center> <b>Good</b> </td> <td style="width: 400px;"> <center><b>Bad</b> </td>
    <tr>
    <td style="width: 400px;">

      ```CXX
      float roll_angle;
      ```

    </td>
    <td style="width: 400px;">

      ```CXX
      float RollAngle;
      float Roll_angle;
      float rollAngle;
      ```
    </td>
    </tr>
    </table>

2. Regular functions are mixed case with capital first letter in each word

    <table>
    <tr>
    <td style="width: 400px;"> <center> <b>Good</b> </td> <td style="width: 400px;"> <center><b>Bad</b> </td>
    <tr>
    <td style="width: 400px;">

      ```CXX
      float WrapToPi(float angle);
      ```

    </td>
    <td style="width: 400px;">

      ```CXX
      float wrap_to_pi(float angle);
      float Wrap_To_Pi(float angle);
      float wraptopi(float angle);
      ```
    </td>
    </tr>
    </table>

3. Class names are mixed case with lower case first letter in each word

    <table>
    <tr>
    <td style="width: 400px;"> <center> <b>Good</b> </td> <td style="width: 400px;"> <center><b>Bad</b> </td>
    <tr>
    <td style="width: 400px;">

      ```CXX
      class VehicleModel;
      ```

    </td>
    <td style="width: 400px;">

      ```CXX
      class vehicle_model;
      class Vehicle_Model;
      ```
    </td>
    </tr>
    </table>

4. Private class members are suffixed with a trailing underscore
    <table>
    <tr>
    <td style="width: 400px;"> <center> <b>Good</b> </td> <td style="width: 400px;"> <center><b>Bad</b> </td>
    <tr>
    <td style="width: 400px;">

      ```CXX
      private:
        float roll_setpoint_;
      ```

    </td>
    <td style="width: 400px;">

      ```CXX
      private:
        // BAD: WinAPI style m_ prefix
        float m_roll_setpoint;

        // BAD: python style prefixed underscore
        float _roll_setpoint;
      ```
    </td>
    </tr>
    </table>

5. Regular methods are mixed case with lower case first letter in the first word; Get / set methods may be named like the member variable minus the underscore suffix.

    <table>
    <tr>
    <td style="width: 400px;"> <center> <b>Good</b> </td> <td style="width: 400px;"> <center><b>Bad</b> </td>
    <tr>
    <td style="width: 400px;">

      ```CXX
      // Regular member function
      void printSetpoints();

      // Getter
      const float& roll_setpoint() const { 
        return roll_setpoint_; 
      }
      
      // Setter
      float& roll_setpoint() {
        return roll_setpoint_;
      }

      // Setter with validation
      void roll_setpoint(float phi) {
        roll_setpoint_ = atan2(sin(phi), cos(phi));
      }
      ```

      Java style is accepted as long as it is conformant

      ```CXX
      const float& GetRollSetpoint() const {
        return roll_setpoint_;
      }

      void SetRollSetpoint(float phi) {
        roll_setpoint_ = atan2(sin(phi), cos(phi));
      }
      ```

    </td>
    <td style="width: 400px;">

      ```CXX
      // BAD: Upper case first letter
      void PrintSetpoints();

      // BAD: underscore separation
      void print_setpoints();

      // BAD: Explicit 'set' should be mixed-case
      void set_roll_setpoint(float phi) {
        roll_setpoint_ = atan2(sin(phi), cos(phi));
      }
      ```
    </td>
    </tr>
    </table>

### Indentation 
1. Indent using **2** spaces everywhere. Do not use tabs.
    <table>
    <tr>
    <td style="width: 400px;"> <center> <b>Good</b> </td> <td style="width: 400px;"> <center><b>Bad</b> </td>
    <tr>
    <td style="width: 400px;">

      ```CXX
      int main(int argc, char** argv) {
        return 0;
      }
      ```

    </td>
    <td style="width: 400px;">

      ```CXX
      int main(int argc, char** argv) {
          return 0;
      }
      ```
    </td>
    </tr>
    </table>

2. Case labels should be indented once, and break statements should be indented once more relative to the case labels. Always use a default case!
    <table>
    <tr>
    <td style="width: 400px;"> <center> <b>Good</b> </td> <td style="width: 400px;"> <center><b>Bad</b> </td>
    <tr>
    <td style="width: 400px;">

    ```CXX
    switch (argc) {
      case 1:
        std::cout << argv[1] << "\n";
        break;
      case 2:
        std::cout << argv[2] << "\n";
        break;
      default:
        std::cout << "Hello World\n";
        break;
    }
    ```

    </td>
    <td style="width: 400px;">

      ```CXX
      switch (argc) {
        case 1:
          std::cout << argv[1] << "\n";
        break; // BAD: Misaligned break
        case 2:
          std::cout << argv[2] << "\n";
        break;
        // BAD: Missing default case!
      }
      ```
    </td>
    </tr>
    </table>

### Braces
1. Place the open brace on the line preceding the code block; place the close brace on its own line. 
    <table>
    <tr>
    <td style="width: 400px;"> <center> <b>Good</b> </td> <td style="width: 400px;"> <center><b>Bad</b> </td>
    <tr>
    <td style="width: 400px;">

      ```CXX
      int main(int argc, char** argv) {
        return 0;
      }
      ```

    </td>
    <td style="width: 400px;">

      ```CXX
      int main(int argc, char** argv) 
      {
        return 0;
      }
      ```

    </td>
    </tr>
    </table>

2. Short functions can be inlined entirely
    ```CXX
    float RadToDeg(float rad) { return 57.29571308232 * rad; }
    ```

3. Both functions and control statements (`if`, `while`, `do`, `else`) should always use braces around the statements. 
    <table>
    <td style="width: 400px;"> <center> <b>Good</b> </td> <td style="width: 400px;"> <center><b>Bad</b> </td>
    <tr>
    <td style="width: 400px;">

      ```C
      if (argv[1]) {
        std::cout << argv[1] << "\n";
      } else {
        std::cout << "Hello World\n";
      }
      ```

    </td>
    <td style="width: 400px;">

      ```C
      if (argv[1])
        std::cout << argv[1];
      else
        std::cout << "Hello World\n";
      
      ```

    </td>
    </tr>
    </table>

### Spacing and Alignment
1. Put one space before and after binary operators (`=`, `+`, `-`, `*`, `%`), logical operators (`&&`, `||`), and the colon `:`
    <table>
    <td style="width: 400px;"> <center> <b>Good</b> </td> <td style="width: 400px;"> <center><b>Bad</b> </td>
    <tr>
    <td style="width: 400px;">

      ```CXX
      float sum = a + b + 2.0f;
      bool conjunction = a && b;
      ```

    </td>
    <td style="width: 400px;">

      ```C
      float sum = a+b+2.0f;
      bool conjunction = a &&b;
      ```

    </td>
    </tr>
    </table>

2. No spaces around unary operators (`++`, `+=`, `--`, etc), dereferencing (`*`, `->`), member invocation (`class.member`), and function call
    <table>
    <td style="width: 400px;"> <center> <b>Good</b> </td> <td style="width: 400px;"> <center><b>Bad</b> </td>
    <tr>
    <td style="width: 400px;">

      ```CXX
      float* ptr = other_ptr++;
      float ret = PassByPtrFunction(*ptr);
      ```

    </td>
    <td style="width: 400px;">

      ```C
      float* ptr = other_ptr ++;
      float ret = PassByPtrFunction (* ptr);
      ```

    </td>
    </tr>
    </table>

3. Pointers and references are aligned left **in declarations**. 
    <table>
    <td style="width: 400px;"> <center> <b>Good</b> </td> <td style="width: 400px;"> <center><b>Bad</b> </td>
    <tr>
    <td style="width: 400px;">

      ```CXX
      float* jacobian;
      float** hessian;

      const auto& tmp = *this;
      ```

    </td>
    <td style="width: 400px;">

      ```C
      float *jacobian
      float * * hessian;

      const auto &tmp = * this;
      ```

    </td>
    </tr>
    </table>

## Best Practices
1. Prefer using the C++ standard library over C libraries, i.e. `#include <iostream>` better than `#include <cstdio>`

    <table>
    <td style="width: 400px;"> <center> <b>Good</b> </td> <td style="width: 400px;"> <center><b>Bad</b> </td>
    <tr>
    <td style="width: 400px;">

      ```CXX
      #include <iostream>

      int main(int argc, char** argv) {
        std::cout << "Hello World\n";
      }
      ```

    </td>
    <td style="width: 400px;">

      ```CXX
      #include <cstdio>

      int main(int argc, char** argv) {
        printf("Hello World\n");
      }
      ```

    </td>
    </tr>
    </table>

0. Prefer `std::string` over C-strings `char*`, except when interacting heavily with the buffer.

0. Never use using directives, i.e. `using namespace std`. 

    <table>
    <td style="width: 400px;"> <center> <b>Good</b> </td> <td style="width: 400px;"> <center><b>Bad</b> </td>
    <tr>
    <td style="width: 400px;">

      ```CXX
      int QuickMaths() {
        using std::sin;
        using std::cos;

        /* Very heavy trig computations */
      }      
      ```

    </td>
    <td style="width: 400px;">

      ```CXX
      using namespace std;
      int QuickMaths() {
        /* Very heavy trig computations */
      }
      ```

    </td>
    </tr>
    </table>

0. Use the `? :` operator if the whole statement fits in a line. Avoid otherwise.
    <table>
    <td style="width: 500px;"> <center> <b>Good</b> </td>
    <tr>
    <td style="width: 500px;">

      ```CXX
      const float phi = (flip) ? atan2(-s, -c) : atan2(s, c);
      ```

    </td>
    </tr>
    </table>
    
0. Declare variables where needed, else wherever closest, and initialize them ASAP.

0. Declare variables to be `const` wherever reasonable

0. Prefer using STL containers over raw arrays or pointers except when performance is critical

    <table>
    <td style="width: 400px;"> <center> <b>Good</b> </td> <td style="width: 400px;"> <center><b>Bad</b> </td>
    <tr>
    <td style="width: 400px;">

      ```CXX
      std::vector<float> data(100);
      ```

    </td>
    <td style="width: 400px;">

      ```CXX
      new float data[100];
      ```

    </td>
    </tr>
    </table>

0. Avoid C-style casts
    <table>
    <td style="width: 400px;"> <center> <b>Good</b> </td> <td style="width: 400px;"> <center><b>Bad</b> </td>
    <tr>
    <td style="width: 400px;">

      ```CXX
      float data = static_cast<float>(dbl_prec);
      ```

    </td>
    <td style="width: 400px;">

      ```CXX
      float data = (float)dbl_prec;
      ```

    </td>
    </tr>
    </table>

0. Prefer passing function arguments by reference, and const reference if the argument is never changed
    <table>
    <td style="width: 400px;"> <center> <b>Good</b> </td> <td style="width: 400px;"> <center><b>Bad</b> </td>
    <tr>
    <td style="width: 400px;">

      ```CXX
      void Foo(const std::string& str) {
        /* Do something */ 
      }
      ```

    </td>
    <td style="width: 400px;">

      ```CXX
      void Foo(std::string str) { 
        /* Do something */ 
      }
      ```

    </td>
    </tr>
    </table>

  0. Use the special name `it` for the iterator variable in range-based for loops and declare as `auto&`, or `const auto&` if the iterator variable is not changed

      <table>
      <td style="width: 400px;"> <center> <b>C++</b> </td> <td style="width: 400px;"> <center><b>Python analog</b> </td>
      <tr>
      <td style="width: 400px;">

        ```CXX
        for (const auto& it : container) {
          /* Work with it */
        }
        ```

      </td>
      <td style="width: 400px;">

        ```python
        for it in container:
          """ work with it """
          pass
        ```

      </td>
      </tr>
      </table>