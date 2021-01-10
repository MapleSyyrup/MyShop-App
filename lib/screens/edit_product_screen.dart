import 'package:flutter/material.dart';
import 'package:myshop_app/providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: null,
    title: '',
    price: 0,
    description: '',
    imageUrl: '',
  );

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() => _formKey.currentState.save();

  Product buildProductImageUrl(Product eProduct, String value) {
    return Product(
      title: eProduct.title,
      price: eProduct.price,
      description: eProduct.description,
      imageUrl: value,
      id: null,
    );
  }

  Product buildProductDescription(Product eProduct, String value) {
    return Product(
      title: eProduct.title,
      price: eProduct.price,
      description: value,
      imageUrl: eProduct.imageUrl,
      id: null,
    );
  }

  Product buildProductPrice(Product eProduct, String value) {
    return Product(
      title: eProduct.title,
      price: double.parse(value),
      description: eProduct.description,
      imageUrl: eProduct.imageUrl,
      id: null,
    );
  }

  Product buildProductTitle(String value, Product eProduct) {
    return Product(
      title: value,
      price: eProduct.price,
      description: eProduct.description,
      imageUrl: eProduct.imageUrl,
      id: null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final focusScope = FocusScope.of(context);
    final eProduct = _editedProduct;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => focusScope.requestFocus(_priceFocusNode),
                onSaved: (value) => _editedProduct = buildProductTitle(value, eProduct),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) => focusScope.requestFocus(_descriptionFocusNode),
                onSaved: (value) => _editedProduct = buildProductPrice(eProduct, value),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                onSaved: (value) => _editedProduct = buildProductDescription(eProduct, value),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(
                      top: 4,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 3,
                        color: Colors.grey,
                      ),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Text('Enter a URL')
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image Url'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (_) => _saveForm(),
                      onSaved: (value) => _editedProduct = buildProductImageUrl(eProduct, value),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
