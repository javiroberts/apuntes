# Practico 1

- Cigoyeneche, Emanuel
- Lo Preiato, Lucas
- Macagno, Julian
- Roberts, Javier

## Identificacion de protocolos

**Consigna**: Realizar un resumen de los protocolos listados.

### Normas IEEE (802.x)

|Estandar|Nombre|Descripcion|
|-|-|-|
|802.1D|STP|Protocolo spanning tree, corre en bridges y switches, su proposito es evitar la creacion de loops o ciclos en caminos redundantes dentro de la red. Se implementa calculando cual es el mejor camino entre los switches en base a la prioridades, y velocidades de los links en la red y bloqueando los puertos que no se deben usar.|
|802.1p|CoS|Es un metodo para asegurar un mejor manejo de los datos que viajan por una red. Funciona asignando prioridades a los paquetes de datos, mediante la adicion del un valor de 3 bits en el header Ethernet.|
|802.1Q|VLAN|Protocolo que permite la comunicacion entre VLANs. En las redes de gran tamanio, se genera un gran consumo de ancho de banda y lentitud en la transferencia, este protocolo nos permite dividir estas redes en subredes mas chicas, rapidas y faciles de administrar, de esta manera el broadcast y multicast consumen mucho menor ancho de banda. Una VLAN consiste en una agrupacion logica de dispositivos sobre una o mas redes fisicas.|
|802.1ad|QinQ|El protocolo anterior (802.1Q) nos permite insertar una sola etiqueta VLAN por trama, en este, podemos insertar mas etiquetas, obteniendo mas de un nivel administrativo, por ejemplo, VLANs de proveedor y VLANs de cliente|
|802.1ag|CFM|Protocolo de gestion de errores de conectividad. Implementa tres protocolos, Continuity Check, Link Trace, Loop-back|
|802.1s|MSTP|Mutiple Spanning Tree protocol, utiliza tramas BPDU al igual que STP, para generar caminos libres de redundancia en cada instancia de multiple spanning tree y en el CIST (common internal spanning tree).|
|802.1w|RSTP|Rapid Spanning Tree Protocol, es el protocolo una mejora sobre el protocolo STP original, responde en la ventana de 3 BPDUs o 6 segundos contra los 50 que podia tardar el original.|
|802.1X|PNAC|Protocolo de acceso a la red basado en puertos, intervienen 3 partes, el suplicante, un servidor de autenticacion y el autenticador|
|802.3i|10BaseT|Definicion del estandar de Ethernet sobre par trenzado el nombre refiere las velocidades de transmision en Mbit/s que puede alcanzar el UTP. Surge como un reemplazo de los distintos medios fisicos que existian en ethernet antes, y introduce comunicacion full-duplex y capacidad de autonegociacion.|
|802.3u|100BaseT|Estandar llamado Fast Ethernet, 10 veces mas rapido que el anterior. El cableado utilizado es UTP cat5|
|802.3x|Flow-Control|Mecanismo que permite que el receptor en una conexion controle la velocidad de envio del emisor. Se implementa gracias a que el estandar permite comunicaciones full-duplex.|
|802.3z|Gigabit|Extiende la velocidad de 100BaseT x10, es decir 1000Mbit/s, permite interconectar switches de alta performance en backbones de LANs|
|802.3ab|1000BaseT|A diferencia de 10 y 100 emplea 4 pares de hilos en el cable, 2 de envio y 2 de recepcion emitiendo simultaneamente por todos ellos. Se desarrollo para poder implementar Fast Ethernet sin provocar cuellos de botella en la red.|
|802.3ac|Q-Tag|Etiquetado de VLAN, extensión de la trama máxima a 1522 bytes (para permitir las "Q-tag") Las Q-tag incluyen información para 802.1Q VLAN y manejan prioridades según el estandar 802.1p.|
|802.3ad|LAG-LACP|Agregacion de enlaces paralelos, LACP controla la implementacion de LAG, protocolo que nos permite distribuir la carga en los enlaces, para tener una red mas tolerante a fallos. Muy usado en backbones.|
|802.3af|PoE|Alimentacion sobre ethernet, contempla el uso de los pares trenzados libres en un cable UTP para la transmision de energia electrica, de esta forma podemos alimentar los dispositivos sin necesidad de una instalacion electrica dedicada.|

### Normas IETF (RFC x)

|RFC|Nombre|Descripcion|
|-|-|-|
|1058|RIPv1|Protocolo utilizado para calcular vectores de distancia en redes. La metrica utilizada para esto es el hop count, es decir la cuenta de saltos. Se utiliza para que los equipos de la red intercambien informacion sobre la topologia de la red.|
|1722/3/4 2453|RIPv2-MIB|Implementacion de RIP en version 2 y SNMP para el control y monitoreo de la misma.|
|2080|RIPng|Implementacion de protocolo RIP sobre redes con tecnologia IPv6 y direcciones multicast.|
|1112|IGMPv1|Protocolo utilizado por equipos en una red para establecer membresia de grupos multicast. Se usa para aplicaciones de red de uno a muchos, por ejemplo el streaming.|
|2236 2933|IGMPv2-MIB|Mejora sobre la primera version de IGMP, agrega mensaje de salida de una estacion entre otras cosas.|
|2365|Multicast|Establece grupos de distribucion de informacion en redes, pueden ser de muchos a muchos o de uno a muchos, la comunicacion se realiza en simultaneo a todos los equipos de la red.|
|3376|IGMPv3|Agrega filtrado de ubicacion, lo que permite a un receptor avisar al router cuales son los grupos desde los que quiere recibir trafico muticast y de cuales origenes espera trafico multicast.|
|2292 2373 2374 2460 2462|IPv6|IPv6 Agrega mas direcciones al rango de IPs disponibles, crea una nueva red paralela e independiente de IPv4 las nuevas direcciones que agrega son de 128 bits, comparadas a las anteriores de 32.|
|2461|NDP|Neighbour Discovery Protocol, responsable de recolectar los parametros de otros dispositivos en la red, por ejemplo la configuracion de conexiones locales, DNS, y gateways.|
|2463 2466|ICMPv6-MIB|Implementacion del protocolo ICMP para IPv6 y definicion de MIB y OIDs SNMP para manejo de informacion.|
|2452 2454|TCP UDP|Definicion de implementacion de los protocolos TCP y UDP para IPv6, definicion de MIB para cada uno de estos protocolos.|
|x|OSPFv2|Open Shortest Path First, Protocolo de routeo para IP, utiliza un algoritmo de Link State, que chequea el estado de los links para calcular la ruta ideal.|
|x|BGPv4|Border Gateway Protocol, protocolo que nos intercambiar informacion de alcanzabilidad de los puntos de routeo.|
