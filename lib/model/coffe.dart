class coffee {
  String name;
  int price;
  String image;
  coffee(this.name, this.image, this.price);
}

List coffee_Names = [
  'Caramel Macchiato',
  'Caramel Cold Drink',
  'Iced Coffe Mocha',
  'Caramelized Pecan Latte',
  'Toffee Nut Latte',
  'Capuchino',
  'Toffee Nut Iced Latte',
  'Americano',
  'Vietnamese',
  'Style_Iced Coffee',
  ' Black Tea Latte',
  ' Classic Irish Coffee',
  ' Toffee Nut Crunch Latte',
];

List coffees = List.generate(coffee_Names.length, (index) => coffee(coffee_Names[index], 'assets/images/coffeImage/${index+1}.png', 50));
