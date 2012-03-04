# TestingARC ##########################################################

This is experimental project to examine how dealloc will be called under ARC.

SBSampleDelegate.h / .m cosists 3 classes:

- SampleClassC
    - Working as a source sender of delegate event
    - This sample code is using timer to send a event with a delay
- SampleClassB
    - Intermediate class working as a bridge between ClassA and ClassC
- SampleClassA
    - Working as a destination of multi-delegate
    - It stores all generated instances of SampleClassB
    - Once it recived delegate event from B, it removes delegate from the list.


SBSampleDelegate.h can configures the project to check how to behave the app.

- kUsingWeak : if it's set as 1, app is using weak reference instead of unsafe_unretained
- kAsseccingViaProperty : if it's set as 1, app is using property to access its delegate instead of using member variable.
- kUsingRetainAutoreleaseHack : if it's set as 1, app is using retain-autorelease hack to avoid EXC_BAD_ACCESS

## Copyright ##########################################################

[TestingARC](https://github.com/takkyun/TestingARC) 
is developed by Takuya Otani / SimpleBoxes.

Copyright (c) 2012 [SerendipityNZ](http://serendipitynz.com/) Ltd. 

## License ##########################################################

TestingARC is released under the MIT-license.

Permission is hereby granted, free of charge, to any person obtaining 
a copy of this software and associated documentation files (the 
"Software"), to deal in the Software without restriction, including 
without limitation the rights to use, copy, modify, merge, publish, 
distribute, sublicense, and/or sell copies of the Software, and to 
permit persons to whom the Software is furnished to do so, subject to 
the following conditions:

The above copyright notice and this permission notice shall be 
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY 
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
