//
//  CardViewTribute.swift
//  DrgonBollWiki
//
//  Created by Esteban Perez Castillejo on 11/3/24.
//

import SwiftUI
let isBiography = """

(鳥山 明 Toriyama Akira?, Nagoya, 5 de abril de 1955-1 de marzo de 2024) fue un mangaka y diseñador de personajes japonés. Primero alcanzó reconocimiento popular tras crear la serie de manga Dr. Slump, y actuar como diseñador de personajes para videojuegos, tales como la serie Dragon Quest, Chrono Trigger y Blue Dragon. Toriyama es considerado uno de los autores más importantes en la historia del manga, especialmente por la creación de Dragon Ball.1​ Autores como Eiichirō Oda y Masashi Kishimoto lo han citado como referente e inspiración para sus obras.2​3
Ganó el Premio Shogakukan Manga de 1981 al mejor manga shōnen con Dr. Slump, el cual llegó a vender más de 35 millones de copias en Japón. Fue adaptado en una exitosa serie de anime, con una segunda serie creada en 1997, 13 años después de que el manga terminara. Su próxima serie, Dragon Ball, se convertiría en uno de los mangas más populares y exitosos del mundo. Con unas ventas de 260 millones de copias en todo el mundo, es una de las series de manga más vendidas de todos los tiempos y se considera una de las principales razones del auge del manga en la década de 1980 y mediados de la década de 1990. En el extranjero, las adaptaciones de anime de Dragon Ball han sido más exitosas que el manga y se les atribuye el impulso de la popularidad del anime en el mundo occidental. En 2019, Toriyama fue condecorado como Caballero de la Orden Francesa de las Artes y las Letras por sus contribuciones al arte.


"""
struct CardViewTribute: View {
    var body: some View {
        VStack{
           
                HStack(alignment: .center){
                    Image("akira")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300).shadow(radius: 10)
                }
                Text("Akira Toriyama").font(.custom("", size: 40)).bold()
                Divider().border(Color.red)
            ScrollView{
                Text(isBiography)
            }
        }.padding()
    }
}

#Preview {
    CardViewTribute()
}
