velocidad = 2;

distancia_deteccion = 200;
distancia_ataque = 35;
distancia_reanudacion = 70;

// Estados:
// 0 = Esperando
// 1 = Persiguiendo
// 2 = En pausa

estado = 0;

lado_objetivo = 0;
////////////////////////////////////////////////////////////////////
// Daño que causa la avispa
danio = 10;

// Tiempo entre golpes
tiempo_entre_ataques = 60;
puede_atacar = true;

// Vida de la avispa
vida_maxima = 30;
vida = vida_maxima;

// Estado
muerta = false;