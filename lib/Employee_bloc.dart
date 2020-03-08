// ---------- Logic of Employee ---------


// TODO: Step 1 >>>    imports

// TODO: Step 2 >>>    List of Employees                      
// TODO: Step 3 >>>    Stream Controllers

// TODO: Step 4 >>>    Stream Sink getter

// TODO: Step 5 >>>    Constructer - add data; listen to changes

// TODO: Step 6 >>>    Core functions

// TODO: Step 7 >>>    dispose


// Step 1
import 'dart:async';
import 'Employee.dart';


// Step 2
class EmployeeBloc {

  // sink - to add in pipe
  // stream - to get data from pipe
  // by pipe i mean data flow

  List<Employee> _employeeList = [
    Employee(1, "Employee One", 10000.0),
    Employee(2, "Employee Two", 20000.0),
    Employee(3, "Employee Three", 30000.0),
    Employee(4, "Employee Four", 40000.0),
    Employee(5, "Employee Five", 50000.0)
  ];


// Step 3
// --- Stream controller for employees ----
final _employeeListStreamController = StreamController<List<Employee>>();

// --- Stream controller for increment and decrement ---
final _employeeSalaryIncrementStreamController = StreamController<Employee>();
final _employeeSalaryDecrementStreamController = StreamController<Employee>();


// Step 4
// ---- getters ----

// getter for output i.e. Stream
Stream<List<Employee>> get employeeListStream => _employeeListStreamController.stream;

// getter for input i.e. Sink
StreamSink<List<Employee>> get employeeListSink => _employeeListStreamController.sink;

// getter for output i.e. Sink increment
StreamSink<Employee> get employeeSalaryIncrement => _employeeSalaryIncrementStreamController.sink;

// getter for output i.e. Sink decrement
StreamSink<Employee> get employeeSalaryDecrement => _employeeSalaryDecrementStreamController.sink;



// Step 5
EmployeeBloc() {
  _employeeListStreamController.add(_employeeList);

  _employeeSalaryIncrementStreamController.stream.listen(_incrementSalary);
  _employeeSalaryDecrementStreamController.stream.listen(_decrementSalary);


}



// Step 6
_incrementSalary(Employee employee) {
  double salary = employee.salary;

  double incrementedSalary = salary * 20/100;

  _employeeList[employee.id -1].salary = salary + incrementedSalary;

  employeeListSink.add(_employeeList);
}

_decrementSalary(Employee employee) {
  double salary = employee.salary;

  double decrementedSalary = salary * 20/100;

  _employeeList[employee.id -1].salary = salary - decrementedSalary;

  employeeListSink.add(_employeeList);

}

void dispose() {
  _employeeSalaryDecrementStreamController.close();
  _employeeSalaryIncrementStreamController.close();
  _employeeListStreamController.close();
}






}

