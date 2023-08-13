import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/web_view_screen.dart';

Widget buildArticleItem(article,context){
  return InkWell(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewScreen(URL: '${article['url']}'),));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 120.0,
            height: 120.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0,),
              image: DecorationImage( 
                image: article['urlToImage']!=null?
                NetworkImage('${article['urlToImage']}') as ImageProvider: AssetImage('assets/images/newsAppimage.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 20,),
          Expanded(
            child: Container(
              height: 120.0,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${article['title']}',
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${article['publishedAt']}',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.0
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget defaultFormField (
    {
      required context,
      Function(String?)? onChanged,
      var onFieldSubmitted,
      required TextEditingController controller,
      bool obscureText=false,
      IconData? suffixIcon,
      // required String? Function(String?)? validate,
      required IconData? prefixIcon,
      required String labelText,
      required bool validation ,
      String? alertText='Field is required',
      var suffixClick,
      String? hitText,
      String? errorText,
      double width=double.infinity,
      TextInputType? keyBoardType,
      ScrollPhysics? scrollPhysics,

    }

    ){
  return
    Container(
      width: width ,
      child: TextFormField(
        scrollPhysics: scrollPhysics,
        style: TextStyle(
          color: Colors.red,


        ),
        onChanged: onChanged,
        keyboardType: keyBoardType,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(

          hintText:hitText ,
          errorText: errorText,
          border: OutlineInputBorder(),
          prefixIcon: Icon(prefixIcon),
          labelText: labelText,
          suffixIcon: suffixIcon !=null ? IconButton(onPressed: suffixClick, icon: Icon(suffixIcon)):null,
        ),
        validator: (value){
          if (validation){

            if(value==null||value.isEmpty){
              return alertText;
            }
            return null;
          }
        },

        onFieldSubmitted: onFieldSubmitted,
      ),
    );
}

