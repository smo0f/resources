<?php
    // @ from john
    // Example Interface: A contract that the class must implement.
    interface SomeInterface {
        public function youMustImplementThisMethod(string $somestring): bool;
        //public function youMustImplementThisMethod2(SomeClass $somestring): AnotherClass;
        //public function youMustImplementThisMethod3(int $somestring): array;
        //public function youMustImplementThisMethod4(int $somestring): Object;
    }

    interface AnotherInterface {
        public function implementThisMethod();
    }

    // Implement interface
    class FullfillContract implements SomeInterface, AnotherInterface { // One class can implement multiple interfaces
        public function youMustImplementThisMethod(string $somestring): bool {
            return true;
        }

        public function implementThisMethod() {
            // Do somthing here
        }
    }

    class FullfillContract2 implements SomeInterface {
        public function youMustImplementThisMethod(string $somestring): bool {
            return true;
        }

    }

    // Interfaces can be injected as dependancies: Any class which implements the interface is accepted
    class InjectInterfaceDependancy{

        private SomeInterface $some_class_that_implements_this_interface;

        public function __construct(SomeInterface $some_class_that_implements_this_interface) {
            $this->some_class_that_implements_this_interface = $some_class_that_implements_this_interface;
        }
    }

    $fullfill_contract = new FullfillContract();
    $fullfill_contract_2 = new FullfillContract2();
    $obj = new InjectInterfaceDependancy($fullfill_contract);
    $obj = new InjectInterfaceDependancy($fullfill_contract_2);


    // Example Abstract class: A class which cannot be instantiated. Any abstract methods must be implmented by child classes. Only one abstract class can be inherited by a child class. Abstract classes CAN contain implementation (Common functionality)
    abstract class SomeAbstractClass {

        abstract public function youMustImplementThisAbstractMethod(): string; // Contact, this method must be defined exectly as shown

        protected function youCanOverrideThis(): bool {
            // Do something
            return true;
        }
    }


    class ChildClass1 extends SomeAbstractClass {

        public function youMustImplementThisAbstractMethod(): string {
            return "Child 1";
        }
    }

    class ChildClass2 extends SomeAbstractClass {

        public function youMustImplementThisAbstractMethod(): string {
            return "Child 2";
        }
    }

    $obj_1 = new ChildClass1();
    $obj_2 = new ChildClass2();

    echo $obj_1->youMustImplementThisAbstractMethod(); // Child 1
    echo $obj_2->youMustImplementThisAbstractMethod(); // Child 2


    // Dependancy injection and Composition
    class InjectDependancies {

        private ChildClass1 $my_child; // Composition: Has-A Relationship

        public function __construct(ChildClass1 $my_child) { // Dependancy Injection - Good for loose coupling and ease of testing
            $this->my_child = $my_child;
        }
    }
?>


<!-- PHP method chaining -->
<?php
    class fakeString {
        private $str;

        function __construct() {
            $this->str = "";
        }
        
        function addA() {
            $this->str .= "a";
            return $this;
        }
        
        function addB() {
            $this->str .= "b";
            return $this;
        }
        
        function getStr() {
            return $this->str;
        }
    }

    $a = new fakeString();

    echo $a->addA()->addB()->addB()->addA()->getStr();
?>



<?php
    // @ accessing private variables
    class Test
    {
        private $foo;

        public function __construct($foo)
        {
            $this->foo = $foo;
        }

        public function __call($method, $args)
        {
            if (isset($this->$method)) {
                $func = $this->$method;
                return call_user_func_array($func, $args);
            }
        }

        public function getFoo()
        {
            var_dump($this->foo);
        }

        private function bar()
        {
            echo 'Accessed the private method.';
        }

        public function baz(Test $other)
        {
            // We can change the private property:
            $other->foo = 'hello';
            var_dump($other->foo);

            // We can also call the private method:
            $other->bar();
        }
    }

    $test = new Test('test');
    $test->baz(new Test('other'));

    // test 2
    $test = new Test('test');
    $test2 = new Test('test2');
    $test->baz($test2);
    var_dump('------------------------');
    $test->getFoo();
    $test2->getFoo();


    // $test->bar = function ($obj) { $obj->foo = 'soso'; };
    
    
    // test 4
    // $test->bar = function ($obj) { $obj->foo = 'soso'; };
    // $cl2 = function ($obj) { $obj->foo = 'soso'; };
    // $bcl2 = Closure::bind($cl2, new Test('test3'), 'Test');
    
    // var_dump('------------------------');
    // $test->getFoo();
    // $test2->getFoo();
    // $bcl2($test);
    // $$test->getFoo();

    // works
    // ? https://www.php.net/manual/en/closure.bindto.php
    // ? https://ocramius.github.io/blog/accessing-private-php-class-members-without-reflection/
    // ? https://stackoverflow.com/questions/18558183/phpunit-mockbuilder-set-mock-object-internal-property
    // class A {
    //     private static $sfoo = 1;
    //     private $ifoo = 2;
    // }
    // $cl1 = static function() {
    //     return A::$sfoo;
    // };
    // $cl2 = function() {
    //     return $this->ifoo;
    // };
    
    // $bcl1 = Closure::bind($cl1, null, 'A');
    // $bcl2 = Closure::bind($cl2, new A(), 'A');
    // echo $bcl1(), "\n";
    // echo $bcl2(), "\n";

    // works!!!
    // ? https://stackoverflow.com/questions/2938004/how-to-add-a-new-method-to-a-php-object-on-the-fly
    class Foo
    {
        public function __call($method, $args)
        {
            if (isset($this->$method)) {
                $func = $this->$method;
                return call_user_func_array($func, $args);
            }
        }
    }

    $foo = new Foo();
    $foo->bar = function ($args) { echo "Hello, this function is added at runtime $args"; };
    $foo->bar('eee');
?>
































<?php
    // @ from john
    // Example Interface: A contract that the class must implement. A Child class can implement multiple interfaces. Interfaces cannot have any implementation.
    interface SomeInterface {
        public function youMustImplementThisMethod(string $somestring): bool;
        //public function youMustImplementThisMethod2(SomeClass $somestring): AnotherClass;
        //public function youMustImplementThisMethod3(int $somestring): array;
        //public function youMustImplementThisMethod4(int $somestring): Object;
    }

    interface AnotherInterface {
        public function implementThisMethod();
    }

    // Implement interface
    class FullfillContract implements SomeInterface, AnotherInterface { // One class can implement multiple interfaces
        public function youMustImplementThisMethod(string $somestring): bool {
            return true;
        }

        public function implementThisMethod() {
            // Do somthing here
        }
    }

    class FullfillContract2 implements SomeInterface {
        public function youMustImplementThisMethod(string $somestring): bool {
            return true;
        }

    }

    // Interfaces can be injected as dependancies: Any class which implements the interface is accepted
    class InjectInterfaceDependancy{

        private SomeInterface $some_class_that_implements_this_interface;

        public function __construct(SomeInterface $some_class_that_implements_this_interface) {
            $this->some_class_that_implements_this_interface = $some_class_that_implements_this_interface;
        }
    }

    $fullfill_contract = new FullfillContract();
    $fullfill_contract_2 = new FullfillContract2();
    $obj = new InjectInterfaceDependancy($fullfill_contract);
    $obj = new InjectInterfaceDependancy($fullfill_contract_2);


    // Example Abstract class: A class which cannot be instantiated. Any abstract methods must be implmented by child classes. Only one abstract class can be inherited by a child class. Abstract classes CAN contain implementation (Common functionality)
    abstract class SomeAbstractClass {

        abstract public function youMustImplementThisAbstractMethod(): string; // Contact, this method must be defined exectly as shown

        protected function youCanOverrideThis(): bool {
            // Do something
            return true;
        }
    }


    class ChildClass1 extends SomeAbstractClass {

        public function youMustImplementThisAbstractMethod(): string {
            return "Child 1";
        }
    }

    class ChildClass2 extends SomeAbstractClass {

        public function youMustImplementThisAbstractMethod(): string {
            return "Child 2";
        }
    }

    $obj_1 = new ChildClass1();
    $obj_2 = new ChildClass2();

    echo $obj_1->youMustImplementThisAbstractMethod(); // Child 1
    echo $obj_2->youMustImplementThisAbstractMethod(); // Child 2


    // Dependancy injection and Composition
    class InjectDependancies {

        private ChildClass1 $my_child; // Composition: Has-A Relationship

        public function __construct(ChildClass1 $my_child) { // Dependancy Injection - Good for loose coupling and ease of testing
            $this->my_child = $my_child;
        }
    }
?>