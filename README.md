MSTimer
=======

A proxy object for NSTimer that avoids retain cycles

#### Why

Retain cycles are annoying to deal with. As explained [here](http://www.mikeash.com/pyblog/friday-qa-2010-04-30-dealing-with-retain-cycles.html).

The problem lies in the fact that if `MyViewController` becomes a `NSTimer`'s target, it is retained by the `NSTimer`. And so if `MyViewController` also happens to own the `NSTimer`, a retain cycle is created.

To fix this problem, we use a proxy object `MSTimer` which takes the burden off of `MyViewController`. So when you dismiss `MyViewController`, its `dealloc` gets called as expected.

#### How To Use

Instantiate using class method, as you would a regular NSTimer. __NOTE: this adds the timer to the runloop with specified mode right away__.

To create one:

    MSTimer *timer = [MSTimer startTimerWithTimeInterval:1 target:self selector:@selector(doSomething) userInfo:nil repeats:YES runLoop:[NSRunLoop currentRunLoop] mode:NSDefaultRunLoopMode];

Treat the timer object as if it was a `NSTimer`:

    [timer isValid];
    [timer setFireDate:[NSDate date]];
    ...

To clean up (__important!!__):

    [timer invalidate];
    [timer release];

#### License

MIT