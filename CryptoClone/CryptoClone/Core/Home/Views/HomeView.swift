//
//  HomeView.swift
//  CryptoClone
//
//  Created by Tasawar Saraf on 6/26/22.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false // to animate right
    
    @State private var showPortfolioView: Bool = false// for a new sheet
    var body: some View {
        ZStack{
            // the higher the ZStack further back
            // this is the background
            Color.theme.background.ignoresSafeArea().sheet(isPresented: $showPortfolioView, content: {
                PortfolioView().environmentObject(vm)
            })
            
            // content layer
            
            VStack{
                
                // this is our custom navigation bar
                homeHeader
                
                HomeStatsView(showPortfolio: $showPortfolio)
                // content layer
                SearchBarView(searchText: $vm.searchText)
                columnTitles
                // pushes it to the left if we switch tabs
                
                if !showPortfolio{
                   allCoinsList.transition(.move(edge: .leading))
                }
                
                if showPortfolio{
                    portfolioCoinsList.transition(.move(edge: .leading))
                }
               
                Spacer(minLength: 0)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            NavigationView{
                // we are replicating this navigation view so we understand
                HomeView().navigationBarHidden(true)
            }.environmentObject(dev.homeVM)
            
            
            
            NavigationView{
                // we are replicating this navigation view so we understand
                HomeView().navigationBarHidden(true)
            }.environmentObject(dev.homeVM).preferredColorScheme(.dark)
        }
        
        
       
        
    }
}


extension HomeView{
    private var homeHeader: some View{
        HStack{
            CircleButtonView(iconName:  showPortfolio ? "plus": "info").animation(.none, value: showPortfolio).onTapGesture {
                if showPortfolio{
                    showPortfolioView.toggle()
                }
            }
                .background(
                CircleButtonAnimationView(animate: $showPortfolio)
            )
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none, value: showPortfolio)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180: 0))
                .onTapGesture {
                withAnimation(.spring()){
                    showPortfolio.toggle()
                }
            }
        }.padding(.horizontal)
    }
    
    
    private var allCoinsList: some View{
        List{
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false).listRowInsets(.init(top:10, leading: 0, bottom: 10, trailing: 10))
            }
        }.listStyle(PlainListStyle())
    }
    
    
    
    private var portfolioCoinsList: some View{
        List{
            // we want the showHolding to be true
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true).listRowInsets(.init(top:10, leading: 0, bottom: 10, trailing: 10))
            }
        }.listStyle(PlainListStyle())
    }
    
    
    private var columnTitles: some View{
        HStack{
            Text("Coin")
            Spacer()
            if showPortfolio{
                Text("Holdings").frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            }
           
            Spacer()
            Text("Price")
        }.font(.caption).foregroundColor(Color.theme.secondaryText).padding(.horizontal)
    }
}
