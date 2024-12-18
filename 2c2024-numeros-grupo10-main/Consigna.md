# Números

## Primera parte

Hacer file-in del archivo Numeros-Parte1-Ejercicio.st.

Como se observa, contamos con una clase Numero que representa un modelo de números. En particular soporta operaciones de enteros y de fracciones.
Contamos con una suite de tests que verifica una serie de operaciones básicas que soporta nuestro modelo.

El objetivo de esta primera parte es quitar los ifs utilizando polimorfismo, aplicando el algoritmo que vimos en clase. 

Los tests deben seguir pasando (sin modificarlos).

## Segunda parte

Para esta segunda parte, deben previamente quitar la categoría Numeros-Parte1-Ejercicio, y luego hacer file-in de Numeros-Parte2-Ejercicio.st.

Este segundo modelo presentado es una posible solución de la primera parte, pero agregando nuevas operaciones: resta, división y fibonacci.

Como podrán ver cuando corran los tests, hay varios que funcionan y son los correspondientes a cuando se opera aritméticamente entre números del mismo tipo, o sea entre enteros o entre fracciones. Los test que fallan son los relacionados a las operaciones entre números de distinto tipo, es decir, entre enteros y fracciones y viceversa.

El objetivo de este ejercicio es que implementen la suma, la resta, la multiplicación y la división entre números enteros y fraccionarios.

La solución final no debe tener if en los métodos que deben implementar y todos los test deben funcionar (sin ser modificados!).

### Fibonacci

Una vez finalizado todo lo anterior, se pide llevar al extremo el reemplazo de if por polimorfismo: Deben quitar los ifs de #fibonacci. 

Las soluciones a este desafío son muy interesantes y distintas para lenguajes de prototipación (ej. javascript) vs clasificación.

**Pasos a seguir para resolver la parte 2:**

1. Antes de empezar a resolver el problema, debuggeen los tests que funcionan para entender cómo es el modelo que se está presentando. Analicen las clases Numero, Entero y Fraccion.
2. Una vez que se sientan cómodos con el modelo, hagan pasar todos los tests implementando lo necesario utilizando ifs. 
3. Una vez que los tests pasen, apliquen el algoritmo que vimos en clase para reemplazar if por polimorfismo.
4. Por último, apliquen el algoritmo y las técnicas vistas en clase para quitar los ifs de #fibonacci.

Para la entrega, deben hacer file-out de la solución a esta segunda parte. No es necesario entregar la solución a la primera parte.

**Algunas aclaraciones:**

- Las fracciones no pueden tener denominador 1. Fracciones con denominador 1 se asumen enteros.
- Los enteros no pueden responder los mensajes #numerador y #denominador ya que no son fracciones.
- Cuando se opera aritméticamente con enteros, verán que se utilizan las operaciones aritméticas provistas por el sistema. Esto es para que sea más performante.

## Desafío Adicional (opcional, no resta, sólo otorga puntos extra)

Aquellos que estén interesados en seguir llevando al extremo el reemplazo de if por polimorfismo (y practicar para el parcial), traten de sacar el resto los ifs que ya venían en el ejercicio inicialmente: Los tienen que ver con que no se puede dividir por cero, que el denominador no puede ser uno, etc... Los van a encontrar en #with:over:

## Preguntas teóricas

### Aporte de los mensajes de DD
En un double dispatch (DD), ¿qué información aporta cada uno de los dos llamados?

Nosotros tenemos un método doblemente polimórfico, y lo que queremos es reducirlo a un solo mensaje polimórfico. El primer llamado (el envío del primer mensaje) se encarga del primer problema polimórfico, y envía otro mensaje al colaborador externo para resolver el polimorfismo restante.

### Lógica de instanciado

Con lo que vieron y saben hasta ahora, ¿dónde les parece mejor tener la lógica de cómo instanciar un objeto? ¿por qué? ¿Y si se crea ese objeto desde diferentes lugares y de diferentes formas? ¿cómo lo resuelven?

El donde iría la lógica de como instanciar un objeto, va a depender del objeto en cuestión. Idealmente, queremos crear objetos "completos" y "válidos". La mejor forma de asegurarnos de esto, es con un mensaje de clase inicializador al cual le pasemos todos los colaboradores internos que precisemos para que el objeto sea completo.

### Nombres de las categorías de métodos

Con lo que vieron y trabajaron hasta ahora, ¿qué criterio están usando para categorizar métodos?

Categorizar métodos es una forma de agruparlos. Por ejemplo, si un método no debe ser expuesto (es para uso interno), podría estar en la categoría "private", o si el método es una operación aritmética (como puede ser "+" o "*"), estar en la categoría "arithmetic operations", y así. Entonces, el criterio que estamos usando, es el de categorizarlos según el comportamiento.

### Subclass Responsibility

Si todas las subclases saben responder un mismo mensaje, ¿por qué ponemos ese mensaje sólo con un “self subclassResponsibility” en la superclase? ¿para qué sirve?

Al escribir “self subclassResponsibility”, estamos diciendo que este comportamiento depende de las subclases, por lo tanto esta superclase pasaría a ser una clase abstracta (y no se debe instanciar), y además estamos obligando a las clases hijas a implementar dicho mensaje. De esta manera, estamos definiendo un comportamiento en común que tienen que implementar todas las subclases, aunque cada una lo haga a su manera.

### No rompas

¿Por qué está mal/qué problemas trae romper encapsulamiento?

Encapsulamiento es uno pilares de la programación orientada a objetos, y tiene que ver con ocultar los detalles de implementación. Romperlo esta mal, ya que cuando un objeto le manda un mensaje a otro, no le interesa saber como lo hace, solamente que lo haga. Si rompemos el encapsulamiento de un objeto, vamos a estar dependiendo de los detalles de implementación de este, lo cual podría generar errores y problemas a futuro (además de que estamos exponiendo información que no le corresponde).