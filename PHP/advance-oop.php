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