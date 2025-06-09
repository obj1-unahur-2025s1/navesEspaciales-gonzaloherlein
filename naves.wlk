class Nave{
  var velocidad
  var direccion
  var combustible

  method acelerar(cuanto){
    velocidad = (velocidad + cuanto).min(100000)
  }

  method desacelerar(cuanto){
    velocidad = (velocidad - cuanto).max(0)
  }

  method irHaciaElSol(){
    direccion = 10
  }

  method escaparDelSol(){
    direccion = -10
  }

  method ponerseParaleloAlSol(){
    direccion = 0
  }

  method acercarseUnPocoAlSol(){
    direccion = (direccion + 1).min(10)
  }

  method alejarseUnPocoAlSol(){
    direccion = (direccion - 1).max(-10)
  }

  method cargarCombustible(cantidad){
    combustible += cantidad
  }

  method descargarCombustible(cantidad){
    combustible -= cantidad
  }
  
  method estaTranquila() = combustible >= 4000 && velocidad <= 12000

  method prepararViaje()
}

class NavesBaliza inherits Nave{
  var colorDeBaliza

  method cambiarColorDeBaliza(colorNuevo){
    colorDeBaliza = colorNuevo
  }

  override method prepararViaje(){
    self.cambiarColorDeBaliza("verde")
    self.ponerseParaleloAlSol()
    self.cargarCombustible(30000)
    self.acelerar(5000)
  }

  override method estaTranquila() = super() && colorDeBaliza != "rojo"
}

class NavesPasajeros inherits Nave{
  const pasajeros
  var comida
  var bebida

  method cargarComida(cantDeComida){
    comida += cantDeComida
  }

  method descargarComida(cantDeComida){
    comida -= cantDeComida
  }

  method cargarBebida(cantDeBebida){
    bebida += cantDeBebida
  }

  method descargarBebida(cantDeBebida){
    bebida -= cantDeBebida
  }

  override method prepararViaje(){
    self.cargarComida(4 * pasajeros)
    self.cargarBebida(6 * pasajeros)
    self.acercarseUnPocoAlSol()
    self.cargarCombustible(30000)
    self.acelerar(5000)
  }
}

class NavesDeCombate inherits Nave{
  var visible
  var misilesDesplegados
  const mensajesEmitidos

  method ponerseVisible(){
    visible = true
  }

  method ponerseInvisible(){
    visible = false
  }
  
  method estaInvisible() = !visible

  method desplegarMisibles(){
    misilesDesplegados = true
  }

  method replegarMisiles(){
    misilesDesplegados = false
  }

  method misilesDesplegados() = misilesDesplegados

  method emitirMensaje(mensaje){
    mensajesEmitidos.add(mensaje)
  }

  method mensajeEmitidos() = mensajesEmitidos

  method primerMensajeEmitido() = mensajesEmitidos.first()

  method ultimoMensajeEmitido() = mensajesEmitidos.last()

  method esEscueta() = mensajesEmitidos.any({m => m.length() > 30})

  method emitioMensaje(mensaje) = mensajesEmitidos.find({m => m == mensaje})

  override method prepararViaje(){
    self.ponerseVisible()
    self.replegarMisiles()
    self.acelerar(15000)
    self.emitirMensaje("Saliendo en Mision")
    self.cargarCombustible(30000)
    self.acelerar(5000)
  }

  override method estaTranquila() = super() && !misilesDesplegados
}

class NaveHospital inherits NavesPasajeros{
  var quirofanosPreparados

  method prepararQuirofanos(){
    quirofanosPreparados = true
  }

  method noPrepararQuirofanos(){
    quirofanosPreparados = false
  }

  override method estaTranquila() = super() && !quirofanosPreparados
}

class NaveCombateSigilosa inherits NavesDeCombate{
  override method estaTranquila() = super() && !self.estaInvisible()
}
