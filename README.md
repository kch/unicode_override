UnicodeOverride
===============

UnicodeOverride is a plugin for Rails 2.3.x that ensures UTF-8 strings are
always returned with their encoding set to UTF-8. This allows your application
to be moved to ruby 1.9.x theorietically seamlessly, hopefully without
agonizing pain.

For ruby 1.8.x, it does nothing, so your application will continue working
under it.


## Installation

Just Put It In Your vendor/plugins™


## Awesomeness

• `String#force_utf8!`

  Strings get a `force_utf8!` method. This is used internally but might be fun
  for everyone. What it does is: when a string forms a valid UTF-8 string, its
  encoding gets forced to UTF-8, otherwise the original encoding is kept.
  Always returns `self``.

• Any ActiveRecord attribute that is a string gets sent `force_utf8!`. This is
  achieved by defining an `after_find` method which acts during object
  instantiation. If you define `after_find` in your own code, be mindful of
  this and use `alias_method_chain` if needed.

• All Rails built-in helpers are enveloped. When they return a string,
  `force_utf8!` is sent to it before it's returned.


## TL;DR

So what we do is we fix strings coming from built-in helpers or from
ActiveRecord objects.


---
Copyright © 2010 Caio Chassot, released under the MIT license
