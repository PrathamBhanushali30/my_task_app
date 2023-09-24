import '../../features/auth/presentation/pages/cart_page/cart_page.dart';
import '../../features/auth/presentation/pages/home_page/home_page.dart';
import '../../features/auth/presentation/pages/user_profile_page/user_profile_page.dart';
import '../imports.dart';

class Constants{
  Constants._();
  static const animationDuration = Duration(milliseconds: 200);
  static const String appLogoName = 'M';

  static const String productName = 'ProductName';
  static const String productImage = 'ProductImage';
  static const String productPrice = 'ProductPrice';
  static const String productDetails = 'ProductDetails';
  static const String productRatings = 'ProductRatings';

  static List<Widget> screenList() => [
    HomePage(),
    const CartPage(),
    UserProfilePage(),
  ];

  static List<String> bannerList = [
    'https://fastly.picsum.photos/id/866/200/300.jpg?hmac=rcadCENKh4rD6MAp6V_ma-AyWv641M4iiOpe1RyFHeI',
    'https://fastly.picsum.photos/id/806/200/300.jpg?hmac=IA-MNmLr1ua-cWJTayRkIMVB9ZU-DrSrJUB_8gi-Xpw',
    'https://fastly.picsum.photos/id/456/200/300.jpg?hmac=p9jAgKWZ8BmAcmdpyO2siEEUZaIzEUHYN64WS2rJNtM'
  ];
}