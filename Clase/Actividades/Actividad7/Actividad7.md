
# Actividad 7

## Descripción del Completely Fair Scheduler (CFS)

El *Completely Fair Scheduler* (CFS) es el planificador de procesos por defecto en Linux y fue introducido con el núcleo 2.6.23. Su objetivo principal es ofrecer una planificación más justa y eficiente para los procesos en ejecución, eliminando los problemas asociados con el antiguo algoritmo O(1) del núcleo.

### Características principales del CFS:

1. **Equidad (Fairness):** El CFS asigna tiempos de CPU de manera justa entre los procesos, intentando que todos los procesos reciban la misma cantidad de tiempo de procesamiento. La justicia se mide en función del tiempo real de CPU que cada proceso ha utilizado en comparación con lo que deberían haber utilizado.

2. **Modelo basado en tiempo de ejecución virtual (vruntime):** El CFS asigna un tiempo de ejecución virtual (vruntime) a cada proceso, el cual refleja el tiempo que ha consumido en la CPU. Cuanto menor sea el vruntime de un proceso, más prioridad tendrá para recibir tiempo de CPU. El CFS selecciona el proceso con el menor vruntime para ser ejecutado.

3. **Árbol rojo-negro (Red-black tree):** El CFS organiza los procesos en un árbol rojo-negro, una estructura de datos que permite una búsqueda eficiente del proceso con menor vruntime. Esto garantiza que las operaciones de planificación tengan un costo logarítmico (O(log n)).

4. **Responsabilidad por grupos:** Permite agrupar procesos de manera que cada grupo reciba una parte justa del tiempo de CPU, independientemente del número de procesos en cada grupo. Esto es útil en sistemas con múltiples usuarios o contenedores.

5. **Latencia máxima de planificación (Scheduler Latency):** Define un período de tiempo máximo en el que cada proceso en la cola de ejecución debe tener al menos una oportunidad para ejecutarse. Esto ayuda a evitar que los procesos con menor prioridad se vean completamente excluidos.

### Funcionamiento del CFS:

- El planificador CFS calcula el tiempo de ejecución virtual para cada proceso, que se incrementa cuando un proceso consume tiempo de CPU.
- Los procesos se organizan en un árbol rojo-negro según su vruntime, y el proceso con el menor vruntime se selecciona para ejecutarse.
- Cuando un proceso es ejecutado, su vruntime aumenta, y el planificador se asegura de que los procesos con menor vruntime (los que han sido menos favorecidos) tengan la siguiente oportunidad de ejecutar.

Esta estrategia elimina la necesidad de *time slices* predefinidos, ya que los procesos se seleccionan en función de su uso efectivo de CPU en lugar de intervalos de tiempo fijos.
