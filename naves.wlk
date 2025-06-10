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

  method recibirAmenaza(){
    self.escapar()
    self.avisar()
  }

  method escapar(){

  }

  method avisar(){

  }

  method estaDeRelajo() = self.estaTranquila() && self.tienePocaActividad()

  method tienePocaActividad() = true

  method prepararViaje()
}

class NavesBaliza inherits Nave{
  var colorDeBaliza
  var cambioElColor

  method cambiarColorDeBaliza(colorNuevo){
    colorDeBaliza = colorNuevo
    cambioElColor = true
  }

  override method prepararViaje(){
    self.cambiarColorDeBaliza("verde")
    self.ponerseParaleloAlSol()
    self.cargarCombustible(30000)
    self.acelerar(5000)
  }

  override method estaTranquila() = super() && colorDeBaliza != "rojo"

  override method escapar(){
    self.irHaciaElSol()
  }

  override method avisar(){
    self.cambiarColorDeBaliza("rojo")
  }

  override method tienePocaActividad() = !cambioElColor
}

class NavesPasajeros inherits Nave{
  const pasajeros
  var comida
  var bebida
  var cantidadDeComidaServida

  method cargarComida(cantDeComida){
    comida += cantDeComida
  }

  method descargarComida(cantDeComida){
    comida = (comida - cantDeComida).max(0)
    cantidadDeComidaServida += cantDeComida
  }

  method cargarBebida(cantDeBebida){
    bebida += cantDeBebida
  }

  method descargarBebida(cantDeBebida){
    bebida = (bebida - cantDeBebida).max(0)
  }

  override method prepararViaje(){
    self.cargarComida(4 * pasajeros)
    self.cargarBebida(6 * pasajeros)
    self.acercarseUnPocoAlSol()
    self.cargarCombustible(30000)
    self.acelerar(5000)
  }

  override method escapar(){
    self.acelerar(velocidad)
  }

  override method avisar(){
    self.descargarComida(pasajeros)
    self.descargarBebida(pasajeros * 2)
  }

  override method tienePocaActividad() = cantidadDeComidaServida < 50
}

class NavesDeCombate inherits Nave{
  var estaInvisible
  var misilesDesplegados
  const mensajesEmitidos = []

  method ponerseVisible(){
    estaInvisible = false
  }

  method ponerseInvisible(){
    estaInvisible = true
  }
  
  method estaInvisible() = estaInvisible

  method desplegarMisiles(){
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

  override method escapar(){
    self.acercarseUnPocoAlSol()
    self.acercarseUnPocoAlSol()
  }

  override method avisar(){
    self.emitirMensaje("Amenaza recibida")
  }
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

  override method recibirAmenaza(){
    super()
    self.prepararQuirofanos()
  }
}

class NaveCombateSigilosa inherits NavesDeCombate{
  override method estaTranquila() = super() && !self.estaInvisible()

  override method escapar(){
    super()
    self.desplegarMisiles()
    self.ponerseInvisible()
  }
}
