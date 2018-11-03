
class Sucursal {

	var property pedidos = []
	var property costoRemera
	var property cantDeRemeras

	method costoRemera() = costoRemera

	method nuevoPedido(unPedido) {
		pedidos.add(unPedido)
	}

	method totalFacturado() = pedidos.sum{ remera => remera.costoRemera() }

	method sucursalQueVendioRemerasDeTodosLosTalles() = pedidos.all{ remera => remera.talle() }

}

class RemerasLisas inherits Sucursal {

	var property talle
	var property coloresBasicos = []
	var property descuento = 0.10
    

     method costoBasePorTalle(){
     	
     	if(self.talle().min(32) < 40){return 80
     	}else{
     	if(self.talle().min(41) < 48){return 100
     	}else{return 0
     	}
      }   
	}

	method costoBase(unColor) {
		if (self.coloresBasicos()) {
			return self.costoBasePorTalle()
		} else {
			return self.costoBasePorTalle() + 0.10
		}
	}

	override method costoRemera(unColor) =  self.costoBase(unColor) - descuento

	method descuento() = descuento

}

class ColoresBasicos  { 
        var property coloresBasicos 
method coloresBasicos() = coloresBasicos
}

class RemerasBordadas inherits Sucursal {

	var descuento

	override method costoRemera(unColor) = super() + bordado.costoBordado()

	method descuento() = descuento

}

class RemerasSublimadas inherits Sucursal {

	var property costoDerechoDeAutor
	var property descuento = 0.20

	override method costoRemera(unColor) {
		if (sublimado.marcas()) {
			return super() + sublimado.costoSublimado() + costoDerechoDeAutor
		} else {
			if (self.cantDeRemeras()) {
				return super() + sublimado.costoSublimado() + self.costoDerechoDeAutor() - descuento
			}
			return super() + sublimado.costoSublimado()
		}
	}

	override method cantDeRemeras() = pedidos.max{ remeras => remeras.cantDeRemeras() }

}

object bordado {

	var property cantDeColores = 20

	method cantDeColores() = cantDeColores

	method costoBordado() = 10.min(20) * cantDeColores

}

object sublimado {

	var property superficie = 20
	var property alto = 10
	var property ancho = 5
	var property marcas = [ ]

	method costoSublimado() = superficie * 50

	method superficie() = alto * ancho

	method marcas() = marcas

}

class Pedidos inherits Sucursal {

	var property remeras = []
	var property precioBase
	var property tipoDeSucursal

	method precioBase() = costoRemera * remeras.cantDeRemeras()

	method pedidoMasCaro() = pedidos.max{ pedido => pedido.precioBase() }

	method cantDePedidos(unColor) = unColor.size()

}

class Empresa inherits Pedidos {

	var property totalFacturado
	var property sucursales = []

	override method totalFacturado() = remeras.sum{ remera => remera.costoRemera() }

	method sucursalQueMasFacturo() = sucursales.max{ sucursal => sucursal.totalFacturado() }

}

