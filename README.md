MSTimer
=======

A proxy object for NSTimer that avoids retain cycles

#### Why

Retain cycles are annoying to deal with. As explained [here](http://www.mikeash.com/pyblog/friday-qa-2010-04-30-dealing-with-retain-cycles.html).

#### How To Use

Instantiate using class method, as you would a regular NSTimer. __NOTE: this adds the timer to the runloop with specified mode right away__.

Example:

    MSTimer *timer = [MSTimer startTimerWithTimeInterval:1 target:self selector:@selector(doSomething) userInfo:nil repeats:YES runLoop:[NSRunLoop currentRunLoop] mode:NSDefaultRunLoopMode];

To clean up

    [timer invalidate];
    [timer release];

#### License

MIT