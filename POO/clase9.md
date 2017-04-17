## Clases Derivadas

```cpp
class Personal {
protected:
    int edad, salario;
public:
    QString verEdad() { return "Edad: "+QString::number(edad); }
    int getSalario() { return salario; }
}
```

```cpp
class Administrativo : public Personal {
    int legajo;
public:
    Administrativo(): legajo(0) { //es igual a this.legajo = 0
        this.edad = 0;
        this.salario = 0;
    }
}
```

Si vemos el constructor tenemos que recordar que solo puedo inicializar por parametros las variables de la clase, no las de la base.

```cpp
class Desarrollador : public Personal {
private:
    QString lenguaje;
public:
    Desarrollador(int edad) : lenguaje("C++") { //inicializacion por parametros
        this.edad = edad;
    }
}
```

Si a la clase base le agrego el constructor, sus derivadas no compilan, porque no saben que constructor utilizar:

```cpp
Personal(int edad, int salario) : edad(edad), salario(salario) { }
```

Solucion:

```cpp
Desarrollador(int edad) : Personal(edad, 0), lenguaje("C++") { }
```

De esta forma elegi que constructor de la clase base utilizar, notar que siempre debe ir antes de todos los parametros de la clase.

Para *destruir* un objeto, el orden correcto es primero el que hereda y despues la base, de esta forma el objeto no queda huerfano.

## Bases de datos

Podemos manejar ODBC, MySQL y SQLite.