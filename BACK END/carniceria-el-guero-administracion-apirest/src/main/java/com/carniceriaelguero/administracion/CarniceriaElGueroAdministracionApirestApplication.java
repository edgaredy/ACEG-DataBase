package com.carniceriaelguero.administracion;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class CarniceriaElGueroAdministracionApirestApplication {

	public static void main(String[] args) {
		SpringApplication.run(CarniceriaElGueroAdministracionApirestApplication.class);
		// SpringApplication.run(CarniceriaElGueroAdministracionApirestApplication.class, args); con esta linea marca un error de seguridad sonar
	}

}
