class Stock {
  final String symbol;
  final String company;
  final double price;

  Stock({required this.symbol, required this.company, required this.price});

  static List<Stock> getAll() {
    List<Stock> stocks = <Stock>[];
    stocks.add(Stock(company: "Adaro Energy Tbk", symbol: "ADRO", price: 1645));
    stocks
        .add(Stock(company: "AKR Corporindo Tbk", symbol: "AKRA", price: 4180));
    stocks.add(
        Stock(company: "Astra International Tbk", symbol: "ASII", price: 6225));
    stocks.add(
        Stock(company: "Bank Central Asia Tbk", symbol: "BBCA", price: 7425));
    stocks.add(
        Stock(company: "Bumi Serpong Damai Tbk", symbol: "BSDE", price: 1185));
    stocks.add(Stock(
        company: "Charoen Pokphand Indonesia Tbk",
        symbol: "CPIN",
        price: 5950));
    stocks
        .add(Stock(company: "Gudang Garam Tbk", symbol: "GGRM", price: 33275));
    stocks.add(Stock(company: "HM Sampoerna Tbk", symbol: "HMSP", price: 1045));
    stocks.add(Stock(
        company: "Indo Tambangraya Megah Tbk", symbol: "ITMG", price: 20175));
    stocks.add(
        Stock(company: "Unilever Indonesia Tbk", symbol: "UNVR", price: 4660));

    return stocks;
  }
}
