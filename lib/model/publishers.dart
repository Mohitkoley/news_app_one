class Publishers {
  String name;
  String logo;
  String domain;
  Publishers({required this.logo, required this.name, required this.domain});
}

class Publisherslist {
  List<Publishers> publisherlist = [
    Publishers(
        name: "The Times of India",
        logo: "assets/publisher_logo/toi.jpg",
        domain: "timesofindia.indiatimes.com"),
    Publishers(
        name: "Free Press Journal",
        logo: "assets/publisher_logo/fpj.jpg",
        domain: "freepressjournal.in"),
    Publishers(
        name: "NDTV",
        logo: "assets/publisher_logo/ndtv.jpg",
        domain: "ndtv.com"),
    Publishers(
        name: "money Control",
        logo: "assets/publisher_logo/moneycontrol.jpg",
        domain: "moneycontrol.com"),
    Publishers(
        name: "India Tv News",
        logo: "assets/publisher_logo/indiatv.jpg",
        domain: "indiatvnews.com"),
    Publishers(
        logo: "assets/publisher_logo/thetelegraph.jpg",
        name: "The Telegraph",
        domain: "telegraphindia.com"),
    Publishers(
        name: "Zee Business",
        logo: "assets/publisher_logo/zeebiz.jpg",
        domain: "zeebiz.com"),
    Publishers(
        name: "Indian Express",
        logo: "assets/publisher_logo/indianexpress.jpg",
        domain: "indianexpress.com"),
    Publishers(
        name: "Business Today",
        logo: "assets/publisher_logo/businesstoday.jpg",
        domain: "businesstoday.in"),
    Publishers(
        name: "Hindustan Times",
        logo: "assets/publisher_logo/hindustantimes.jpg",
        domain: "hindustantimes.com "),
    Publishers(
        name: "Inside Sports",
        logo: "assets/publisher_logo/insidesports.jpg",
        domain: "insidesport.in"),
    Publishers(
        name: "The Wire",
        logo: "assets/publisher_logo/thewire.jpg",
        domain: "thewire.in"),
    Publishers(
        name: "Live mint",
        logo: "assets/publisher_logo/mint.jpg",
        domain: "livemint.com"),
    Publishers(
        name: "XDA Developer",
        logo: "assets/publisher_logo/xda.jpg",
        domain: "xda-developers.com"),
  ];
}
