## Consultas a DB

Por ejemplo, para un ejercicio del parcial podria ser un login a donde tenga que validar un usuario contra la base de datos. Una posible forma es:

```cpp
void Login::slot_validarUsuario() {
    if(adminDB->getDB().isOpen()) {
        QSqlQuery *query = new QSqlQuery(adminDB->getDB());
        query->exec("SELECT nombre, apellido, id FROM usuarios WHERE usuario='" + leUsuario->text() + "' AND clave='" + leClave->text() + "'");
        qDebug() << query->lastQuery(); //devuelve la ultima consulta a la DB
        qdebug() << query->lastError(); //devuelve el ultimo error
        
        while(query->next()) {
            QSqlRecord record = query->record();
            int colNombre = record.indexOf("nombre");
            int colApellido = record.indexOf("apellido");
            int colId = record.indexOf("id");
            qDebug() << "Bienvenido " << query->value(colNombre).toString() << " " << query->value(colApellido).toString(); //devuelve un QVariant, ver de hacer esto con el record directamente
            usuarioValido = true;
        }

        if(usuarioValido) QMessageBox::information(this, "Info", "bienvenido");
        else QMessageBox::critical(this, "Sin Permisos", "Usuario o clave incorrecta");
    }
}
```