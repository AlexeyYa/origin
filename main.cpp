#include <iostream>
#include <stdlib.h>
#include <stdio.h>
#include "tutorial.h"
#ifdef USE_MYMATH
#  include "MathFunctions.h"
#endif

using namespace std;

int main(int args, char ** argv)
{
  double inputValue = strtod(argv[1], NULL);
#ifdef USE_MYMATH
  const double outputValue = mysqrt(inputValue);
#else
  const double outputValue = inputValue + 2;
#endif

  cout << "Hello World! OutVal " << outputValue << endl;
  return 0;
}
