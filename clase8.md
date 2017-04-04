## QNetworkAccessManager

### Protocolos
```
HTTP ---------------------------------------------|GET| /index.html
TCP ------------------------------------|port|port|-----------datos
IP  --------------------|iporigen|ipdest|---------------------datos
MAC macorigen|macdestino|-------------------------------------datos|CRC
```

### Respuesta (QNetworkReply)
- Luego de usar readAll() sobre QNetworkReply, los datos se destruyen.
- Trae la SIGNAL() para el slot que usa como callback

### Proxy (QNetworkProxyFactory)
En las compus de la UBP necesitamos salir a internet si o si a traves de un proxy, para eso usamos:
```cpp
QNetworkProxyFactory::setUserSystemConfiguration(true)
```