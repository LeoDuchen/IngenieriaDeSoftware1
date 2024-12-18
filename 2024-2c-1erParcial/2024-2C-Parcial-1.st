!classDefinition: #TestMyA category: #'2024-2C-Parcial-1'!
TestCase subclass: #TestMyA
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 03:49:05'!
test01UnMonstruoAtacaAUnAventureroUsandoSusPVs

	| guerrero |
	
	guerrero := self crearGuerrero.
	
	self crearGoblin atacarA: guerrero.
	
	self assert: (guerrero tienePuntosDeVida: 10 * pv - (5 * pv))! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:09:06'!
test02UnAventureroPuedeUsarItemsDeDefensaParaProtegerse

	| guerrero |
	
	guerrero := self crearGuerrero.
	guerrero equiparItemDeDefensa: self crearEscudoMagico.
	guerrero equiparItemDeDefensa: self crearArmadura.
	
	self crearOgro atacarA: guerrero.
	
	self assert: (guerrero tienePuntosDeVida: 10 * pv - (15 * pv - (5 * pv) - (3 * pv)))! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:08:35'!
test03LosItemsDeDefensaNoPuedenAumentarLosPuntosDeVidaDelAventurero

	| guerrero |
	
	guerrero := self crearGuerrero.
	guerrero equiparItemDeDefensa: self crearArmadura.
	guerrero equiparItemDeDefensa: self crearArmadura.
	
	self crearGoblin atacarA: guerrero.
	
	self assert: (guerrero tienePuntosDeVida: 10 * pv)! !

!TestMyA methodsFor: 'tests' stamp: 'HAW 9/27/2024 09:04:39'!
test04UnAventureroNoPuedeAtacarSinItemsEquipados

	| guerrero ogro espada |
	
	guerrero := self crearGuerrero.
	ogro := self crearOgro.
	espada := self crearEspadaPara: ogro.
	
	self should: [ guerrero atacarA: ogro con: (espada) ] 
		raise: Error-MessageNotUnderstood 
		withExceptionDo: [ :anException |
			self assert: anException messageText equals: guerrero itemNoDisponibleMensajeDeError.
			self assert: (ogro tienePuntosDeVida: 15 * pv)
	]
	! !

!TestMyA methodsFor: 'tests' stamp: 'LL 9/27/2024 10:48:15'!
test05UnGuerreroConEspadaProvocaDañoSegunSuFuerza

	| guerrero ogro itemDeAtaque otroItemDeAtaque otroOgro |
	
	guerrero := self crearGuerrero.
	ogro := self crearOgro.
	itemDeAtaque := self crearEspadaPara: ogro.
	guerrero equiparItemDeAtaque: itemDeAtaque.
	otroOgro := self crearOgro.
	otroItemDeAtaque := self crearEspadaPara: otroOgro.
	guerrero equiparItemDeAtaque: otroItemDeAtaque.
	
	guerrero atacarA: ogro con: itemDeAtaque.
	guerrero atacarA: otroOgro con: otroItemDeAtaque.
	
	self assert: (ogro tienePuntosDeVida: 15 * pv - (4 * pv)).
	self assert: (otroOgro tienePuntosDeVida: 15 * pv - (4 * pv)).
	self assert: (guerrero tienePuntosDeVida: 10 * pv)! !

!TestMyA methodsFor: 'tests' stamp: 'HAW 9/27/2024 09:46:06'!
test06UnGuerreroConEspadaNoProvocaDañoAOtroMonstruoQueNoSeaElDeLaEspada

	| guerrero ogroNoObjetivoDeAtaque itemDeAtaque ogroObjetivoDeAtaque |
	
	guerrero := self crearGuerrero.
	ogroObjetivoDeAtaque := self crearOgro.
	itemDeAtaque := self crearEspadaPara: ogroObjetivoDeAtaque.
	guerrero equiparItemDeAtaque: itemDeAtaque.
	ogroNoObjetivoDeAtaque := self crearOgro.
	
	guerrero atacarA: ogroNoObjetivoDeAtaque con: itemDeAtaque.
	
	self assert: (ogroNoObjetivoDeAtaque tienePuntosDeVida: 15 * pv)! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:08:52'!
test07UnAventureroNoGuerreroPierdeTodosSusPuntosDeVidaSiUsaLaEspada

	| ogro mago itemDeAtaque |
	
	mago := self crearMago.
	ogro := self crearOgro.
	itemDeAtaque := self crearEspadaPara: ogro.
	mago equiparItemDeAtaque: itemDeAtaque.
	
	mago atacarA: ogro con: itemDeAtaque.
	
	self assert: (ogro tienePuntosDeVida: 15 * pv).
	self assert: (mago tienePuntosDeVida: 0)! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:08:49'!
test08ElMagoUsandoElBaculoMataAlGoblin

	| mago goblin itemDeAtaque |
	
	mago := self crearMago.
	itemDeAtaque := self crearBaculo.
	mago equiparItemDeAtaque: itemDeAtaque.
	goblin :=  self crearGoblin.
	
	mago atacarA: goblin con: itemDeAtaque.
	
	self assert: (goblin tienePuntosDeVida: 0)! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:42:13'!
test09ElMagoUsandoElBaculoDañaAOtrosMonstruosSegunSuFuerza

	| mago ogro itemDeAtaque |
	
	mago := self crearMago.
	itemDeAtaque := self crearBaculo.
	mago equiparItemDeAtaque: itemDeAtaque.
	ogro := self crearOgro.
	
	mago atacarA: ogro con: itemDeAtaque.
	
	self assert: (ogro tienePuntosDeVida: 15 * pv - (2 * pv))! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:08:45'!
test10UnAventureroNoMagoEsPenalizadoAlUsarElBaculoDuplicandoPVDeGoblins

	| guerrero goblin itemDeAtaque |
	
	guerrero := self crearGuerrero.
	itemDeAtaque := self crearBaculo.
	guerrero equiparItemDeAtaque: itemDeAtaque.
	goblin := self crearGoblin.
	
	guerrero atacarA: goblin con: itemDeAtaque.
	
	self assert: (goblin tienePuntosDeVida: 5 * pv * 2)! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:08:38'!
test11UnAventureroNoMagoUsandoElBaculoDañaSegunSuFuerzaAOtrosMonstruos

	| guerrero ogro itemDeAtaque |
	
	guerrero := self crearGuerrero.
	itemDeAtaque := self crearBaculo.
	guerrero equiparItemDeAtaque: itemDeAtaque.
	ogro := self crearOgro.
	
	guerrero atacarA: ogro con: itemDeAtaque.
	
	self assert: (ogro tienePuntosDeVida: 15 * pv - (4 * pv))! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:29:01'!
test12UnaEspadaNuncaPuedeSerUsadaEnMonstruosDeMenosDeUnMetro

	| goblin |
	
	goblin := self crearGoblin.
	
	self should: [ self crearEspadaPara: goblin ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
		self assert: anException messageText equals: Espada noSePuedeAtacarAMonstruoMenorAUnMetroDeAlturaMensajeDeError
	]
	! !


!TestMyA methodsFor: 'crear items' stamp: 'LD 9/27/2024 20:11:39'!
crearArmadura

	^Armadura new.! !

!TestMyA methodsFor: 'crear items' stamp: 'LD 9/27/2024 20:02:57'!
crearBaculo
	
	^Baculo new.! !

!TestMyA methodsFor: 'crear items' stamp: 'LD 9/27/2024 20:11:35'!
crearEscudoMagico

	^EscudoMagico new.
! !

!TestMyA methodsFor: 'crear items' stamp: 'LD 9/27/2024 19:59:05'!
crearEspadaPara: monstruo

	^Espada para: monstruo.
! !


!TestMyA methodsFor: 'crear combatientes' stamp: 'LD 9/27/2024 20:19:46'!
crearGoblin

	^Goblin new.
! !

!TestMyA methodsFor: 'crear combatientes' stamp: 'LD 9/27/2024 20:24:39'!
crearGuerrero
	
	^Guerrero new.! !

!TestMyA methodsFor: 'crear combatientes' stamp: 'LD 9/27/2024 20:24:43'!
crearMago

	^Mago new.! !

!TestMyA methodsFor: 'crear combatientes' stamp: 'LD 9/27/2024 20:19:51'!
crearOgro

	^Ogro new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TestMyA class' category: #'2024-2C-Parcial-1'!
TestMyA class
	instanceVariableNames: ''!

!TestMyA class methodsFor: 'initialization' stamp: 'LL 9/26/2024 20:21:50'!
initialize

	Smalltalk at: #pv put: (BaseUnit named: 'pv' sign: 'pv')! !


!classDefinition: #Aventurero category: #'2024-2C-Parcial-1'!
Object subclass: #Aventurero
	instanceVariableNames: 'fuerza puntosDeVida itemsDeAtaque itemsDeDefensa'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Aventurero methodsFor: 'error' stamp: 'LD 9/27/2024 19:51:36'!
itemNoDisponibleMensajeDeError

	^'No existe ese item en las armas equipadas.'! !


!Aventurero methodsFor: 'initialization' stamp: 'LD 9/27/2024 20:25:16'!
initialize

	itemsDeAtaque := OrderedCollection new.
	itemsDeDefensa := OrderedCollection new.! !


!Aventurero methodsFor: 'combate' stamp: 'LD 9/27/2024 20:35:28'!
atacarA: unMonstruo con: unItemDeAtaque

	self subclassResponsibility.! !

!Aventurero methodsFor: 'combate' stamp: 'LD 9/27/2024 18:18:20'!
dañoAbsorbidoPorItemsDeDefensa
	
	itemsDeDefensa ifNotEmpty: [
		^itemsDeDefensa sum: [ :unItemDeDefensa | unItemDeDefensa dañoQuePuedeAbsorber].
	].
	
	^0.! !

!Aventurero methodsFor: 'combate' stamp: 'LD 9/27/2024 18:11:47'!
recibirDaño: unaCantidadDeDaño

	puntosDeVida := puntosDeVida - ((unaCantidadDeDaño - (self dañoAbsorbidoPorItemsDeDefensa)) max: 0 * pv).! !

!Aventurero methodsFor: 'combate' stamp: 'LD 9/27/2024 19:23:35'!
recibirDañoPorPenalizacion

	puntosDeVida := 0.! !

!Aventurero methodsFor: 'combate' stamp: 'LD 9/27/2024 17:45:31'!
tienePuntosDeVida: unaCantidadDePuntosDeVidaAComparar

	^(puntosDeVida = unaCantidadDePuntosDeVidaAComparar).! !


!Aventurero methodsFor: 'equipo' stamp: 'LD 9/27/2024 20:52:17'!
equipamientoDeAtaque

	^itemsDeAtaque.! !

!Aventurero methodsFor: 'equipo' stamp: 'LD 9/27/2024 18:48:15'!
equiparItemDeAtaque: unItemDeAtaque

	itemsDeAtaque add: unItemDeAtaque.! !

!Aventurero methodsFor: 'equipo' stamp: 'LD 9/27/2024 17:53:12'!
equiparItemDeDefensa: unItemDeDefensa

	itemsDeDefensa add: unItemDeDefensa.! !


!classDefinition: #Guerrero category: #'2024-2C-Parcial-1'!
Aventurero subclass: #Guerrero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Guerrero methodsFor: 'combate' stamp: 'LD 9/27/2024 20:51:07'!
atacarA: unMonstruo con: unItemDeAtaque

	unItemDeAtaque usadoPorUnGuerrero: self AtacaA: unMonstruo conFuerza: fuerza.! !


!Guerrero methodsFor: 'initialization' stamp: 'LD 9/27/2024 20:27:37'!
initialize

	puntosDeVida := 10 * pv.
	fuerza := 4.
	super initialize.! !


!classDefinition: #Mago category: #'2024-2C-Parcial-1'!
Aventurero subclass: #Mago
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Mago methodsFor: 'initialization' stamp: 'LD 9/27/2024 20:27:39'!
initialize

	puntosDeVida := 15 * pv.
	fuerza := 2.
	super initialize.! !


!Mago methodsFor: 'combate' stamp: 'LD 9/27/2024 20:51:12'!
atacarA: unMonstruo con: unItemDeAtaque

	unItemDeAtaque usadoPorUnMago: self AtacaA: unMonstruo conFuerza: fuerza.! !


!classDefinition: #ItemDeAtaque category: #'2024-2C-Parcial-1'!
Object subclass: #ItemDeAtaque
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!ItemDeAtaque methodsFor: 'combate' stamp: 'LD 9/27/2024 21:15:00'!
usadoPorUnGuerrero: unGuerrero AtacaA: unMonstruo conFuerza: unaFuerza

	self subclassResponsibility.! !

!ItemDeAtaque methodsFor: 'combate' stamp: 'LD 9/27/2024 21:14:50'!
usadoPorUnMago: unMago AtacaA: unMonstruo conFuerza: unaFuerza

	self subclassResponsibility.! !


!classDefinition: #Baculo category: #'2024-2C-Parcial-1'!
ItemDeAtaque subclass: #Baculo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Baculo methodsFor: 'combate' stamp: 'LD 9/27/2024 21:01:41'!
usadoPorUnGuerrero: unGuerrero AtacaA: unMonstruo conFuerza: unaFuerza

	unMonstruo recibeDañoDeUnBaculoUsadoPorUnGuerreroConFuerza: unaFuerza.! !

!Baculo methodsFor: 'combate' stamp: 'LD 9/27/2024 21:00:20'!
usadoPorUnMago: unMago AtacaA: unMonstruo conFuerza: unaFuerza

	unMonstruo recibeDañoDeUnBaculoUsadoPorUnMagoConFuerza: unaFuerza.! !


!classDefinition: #Espada category: #'2024-2C-Parcial-1'!
ItemDeAtaque subclass: #Espada
	instanceVariableNames: 'enemigo'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Espada methodsFor: 'combate' stamp: 'LD 9/27/2024 21:13:15'!
atacarA: unMonstruo conDaño: unaCantidadDeDañoARecibir

	(unMonstruo = enemigo) ifTrue: [ unMonstruo recibirDaño: unaCantidadDeDañoARecibir ].! !

!Espada methodsFor: 'combate' stamp: 'LD 9/27/2024 20:51:58'!
usadoPorUnGuerrero: unGuerrero AtacaA: unMonstruo conFuerza: unaFuerza

	unGuerrero equipamientoDeAtaque detect: [:itemDeAtaqueEnElEquipo | itemDeAtaqueEnElEquipo = self] ifNone: [ self error: unGuerrero itemNoDisponibleMensajeDeError ].
	
	self atacarA: unMonstruo conDaño: unaFuerza.! !

!Espada methodsFor: 'combate' stamp: 'LD 9/27/2024 20:48:14'!
usadoPorUnMago: unMago AtacaA: unMonstruo conFuerza: unaFuerza

	unMago recibirDañoPorPenalizacion.! !


!Espada methodsFor: 'initialization' stamp: 'LD 9/27/2024 21:25:16'!
initializePara: unEnemigo

	(unEnemigo mideMasDeUnMetro) ifTrue: [ self error: self class noSePuedeAtacarAMonstruoMenorAUnMetroDeAlturaMensajeDeError ].

	enemigo := unEnemigo.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Espada class' category: #'2024-2C-Parcial-1'!
Espada class
	instanceVariableNames: ''!

!Espada class methodsFor: 'as yet unclassified' stamp: 'LD 9/27/2024 20:08:32'!
noSePuedeAtacarAMonstruoMenorAUnMetroDeAlturaMensajeDeError

	^'La espada no puede tener como enemigo a un monstruo menor a un metro.'! !

!Espada class methodsFor: 'as yet unclassified' stamp: 'LD 9/27/2024 20:00:52'!
para: unEnemigo

	^self new initializePara: unEnemigo.! !


!classDefinition: #ItemDeDefensa category: #'2024-2C-Parcial-1'!
Object subclass: #ItemDeDefensa
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!ItemDeDefensa methodsFor: 'combate' stamp: 'LD 9/27/2024 20:13:54'!
dañoQuePuedeAbsorber

	self subclassResponsibility.! !


!classDefinition: #Armadura category: #'2024-2C-Parcial-1'!
ItemDeDefensa subclass: #Armadura
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Armadura methodsFor: 'combate' stamp: 'LD 9/27/2024 20:14:19'!
dañoQuePuedeAbsorber
	
	^5 * pv.! !


!classDefinition: #EscudoMagico category: #'2024-2C-Parcial-1'!
ItemDeDefensa subclass: #EscudoMagico
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!EscudoMagico methodsFor: 'combate' stamp: 'LD 9/27/2024 20:14:23'!
dañoQuePuedeAbsorber
	
	^3 * pv.! !


!classDefinition: #Monstruo category: #'2024-2C-Parcial-1'!
Object subclass: #Monstruo
	instanceVariableNames: 'altura puntosDeVida'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Monstruo methodsFor: 'comparing' stamp: 'LD 9/27/2024 21:25:16'!
mideMasDeUnMetro

	^(altura < (100 * centimeter)).! !


!Monstruo methodsFor: 'combate' stamp: 'LD 9/27/2024 17:42:03'!
atacarA: unAventurero

	unAventurero recibirDaño: self dañoAInfligir.! !

!Monstruo methodsFor: 'combate' stamp: 'LD 9/27/2024 20:20:39'!
dañoAInfligir

	^puntosDeVida.! !

!Monstruo methodsFor: 'combate' stamp: 'LD 9/27/2024 21:29:06'!
recibeDañoDeUnBaculoUsadoPorUnGuerreroConFuerza: unaFuerza
	
	self subclassResponsibility.! !

!Monstruo methodsFor: 'combate' stamp: 'LD 9/27/2024 21:28:52'!
recibeDañoDeUnBaculoUsadoPorUnMagoConFuerza: unaFuerza
	
	self subclassResponsibility.! !

!Monstruo methodsFor: 'combate' stamp: 'LD 9/27/2024 19:19:28'!
recibirDaño: unaCantidadDeDaño

	puntosDeVida := puntosDeVida - (unaCantidadDeDaño * pv).! !

!Monstruo methodsFor: 'combate' stamp: 'LD 9/27/2024 18:23:26'!
tienePuntosDeVida: unaCantidadDePuntosDeVidaAComparar

	^(puntosDeVida = unaCantidadDePuntosDeVidaAComparar).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Monstruo class' category: #'2024-2C-Parcial-1'!
Monstruo class
	instanceVariableNames: ''!

!Monstruo class methodsFor: 'as yet unclassified' stamp: 'LD 9/27/2024 18:36:13'!
goblin

	^self new initializeConTipo: #goblin.! !

!Monstruo class methodsFor: 'as yet unclassified' stamp: 'LD 9/27/2024 18:36:12'!
ogro

	^self new initializeConTipo: #ogro.! !


!classDefinition: #Goblin category: #'2024-2C-Parcial-1'!
Monstruo subclass: #Goblin
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Goblin methodsFor: 'initialization' stamp: 'LD 9/27/2024 20:18:37'!
initialize

	puntosDeVida := 5 * pv.
	altura := 90 * centimeter.! !


!Goblin methodsFor: 'combate' stamp: 'LD 9/27/2024 20:22:25'!
duplicarPuntosDeVida

	puntosDeVida := puntosDeVida * 2.! !

!Goblin methodsFor: 'combate' stamp: 'LD 9/27/2024 21:00:52'!
recibeDañoDeUnBaculoUsadoPorUnGuerreroConFuerza: unaFuerza
	
	self duplicarPuntosDeVida.! !

!Goblin methodsFor: 'combate' stamp: 'LD 9/27/2024 21:00:08'!
recibeDañoDeUnBaculoUsadoPorUnMagoConFuerza: unaFuerza

	self recibirGolpeFatal.! !

!Goblin methodsFor: 'combate' stamp: 'LD 9/27/2024 20:22:40'!
recibirGolpeFatal
	
	puntosDeVida := 0.! !


!classDefinition: #Ogro category: #'2024-2C-Parcial-1'!
Monstruo subclass: #Ogro
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Ogro methodsFor: 'initialization' stamp: 'LD 9/27/2024 20:18:33'!
initialize

	puntosDeVida := 15 * pv.
	altura := 220 * centimeter.! !


!Ogro methodsFor: 'combate' stamp: 'LD 9/27/2024 21:01:23'!
recibeDañoDeUnBaculoUsadoPorUnGuerreroConFuerza: unaFuerza
	
	self recibirDaño: unaFuerza.! !

!Ogro methodsFor: 'combate' stamp: 'LD 9/27/2024 21:06:05'!
recibeDañoDeUnBaculoUsadoPorUnMagoConFuerza: unaFuerza
	
	self recibirDaño: unaFuerza.! !

TestMyA initialize!