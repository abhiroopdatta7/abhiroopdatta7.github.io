
If you want to run or update a task when certain files are updated, the make utility can come in handy. The make utility requires a file, Makefile (or makefile), which defines set of tasks to be executed. You may have used make to compile a program from source code. Most open source projects use make to compile a final executable binary, which can then be installed using make install.

In this article, we'll explore make and Makefile using basic and advanced examples. Before you start, ensure that make is installed in your system.

Basic examples
Let's start by printing the classic "Hello World" on the terminal. Create a empty directory myproject containing a file Makefile with this content:

```Makefile
say_hello:
        echo "Hello World"
```

Now run the file by typing make inside the directory myproject. The output will be:

```output
$ make
echo "Hello World"
Hello World
```

In the example above, say_hello behaves like a function name, as in any programming language. This is called the target. The prerequisites or dependencies follow the target. For the sake of simplicity, we have not defined any prerequisites in this example. The command echo "Hello World" is called the recipe. The recipe uses prerequisites to make a target. The target, prerequisites, and recipes together make a rule.

To summarize, below is the syntax of a typical rule:

```Makefile
target: prerequisites
<TAB> recipe
```

Going back to the example above, when make was executed, the entire command echo "Hello World" was displayed, followed by actual command output. We often don't want that. To suppress echoing the actual command, we need to start echo with @:

```Makefile
say_hello:
        @echo "Hello World"
```

Now try to run make again. The output should display only this:

```output
$ make
Hello World
```
