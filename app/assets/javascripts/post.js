(function() {
  function WEBRUBY(opts) {
    if (!(this instanceof WEBRUBY)) {
      // Well, this is not perfect, but it can at least cover some cases.
      return new WEBRUBY(opts);
    }
    opts = opts || {};

    // Default print level is errors only
    this.print_level = opts.print_level || 1;
    this.mrb = _mrb_open();
  };

  WEBRUBY.prototype.close = function() {
    _mrb_close(this.mrb);
  };
  WEBRUBY.prototype.run = function() {
    _webruby_internal_run(this.mrb, this.print_level);
  };
  WEBRUBY.prototype.run_bytecode = function(bc) {
    var stack = Runtime.stackSave();
    var addr = Runtime.stackAlloc(bc.length);
    var ret;
    writeArrayToMemory(bc, addr);

    ret = _webruby_internal_run_bytecode(this.mrb, addr, this.print_level);

    Runtime.stackRestore(stack);
    return ret;
  };
  WEBRUBY.prototype.run_source = function(src) {
    var stack = Runtime.stackSave();
    var addr = Runtime.stackAlloc(src.length);
    var ret;
    writeStringToMemory(src, addr);

    ret = _webruby_internal_run_source(this.mrb, addr, this.print_level);

    Runtime.stackRestore(stack);
    return ret;
  };

  if (typeof window === 'object') {
    window['WEBRUBY'] = WEBRUBY;
  } else {
    global['WEBRUBY'] = WEBRUBY;
  }
}) ();
