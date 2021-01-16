import 'package:flutter/material.dart';
import 'package:myshop_app/providers/product.dart';
import 'package:myshop_app/providers/products_provider.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _textController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

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
      if ((!_imageUrlController.text.startsWith('http') && !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _formKey.currentState.validate();
    final newProduct = Product(
      title: _textController.text,
      price: double.parse(_priceController.text),
      description: _descriptionController.text,
      imageUrl: _imageUrlController.text,
      id: DateTime.now().toString(),
    );
    _formKey.currentState.save();
    if (!isValid) {
      return;
    }

    _formKey.currentState.save();
    Provider.of<ProductsProvider>(context, listen: false).addProduct(newProduct);
    Navigator.of(context).pop();
  }

  String validatorImageUrl(String value) {
    if (value.isEmpty) {
      return 'Please enter an image URL';
    }
    if (value.startsWith('http') && !value.startsWith('https')) {
      return 'Please enter a valid URL.';
    }
    if (!value.endsWith('.png') && !value.endsWith('jpg') && !value.endsWith('.jpeg')) {
      return 'Please enter a valid image URL.';
    }
    return null;
  }

  String validatorDescription(String value) {
    if (value.isEmpty) {
      return 'Please enter a description';
    }
    if (value.length < 10) {
      return 'Please enter more than 10 characters';
    }
    return null;
  }

  String validatorPrice(String value) {
    if (value.isEmpty) {
      return 'Please enter a price.';
    }
    if (double.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    if (double.parse(value) <= 0) {
      return 'Please enter a number greater than zero.';
    }
    return null;
  }

  String validatorTitle(String value) {
    return value.isEmpty ? 'Error description exampler' : null;
  }

  @override
  Widget build(BuildContext context) {
    final focusScope = FocusScope.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => _saveForm(),
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
                controller: _textController,
                validator: validatorTitle,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) => focusScope.requestFocus(_descriptionFocusNode),
                controller: _priceController,
                validator: validatorPrice,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                controller: _descriptionController,
                validator: validatorDescription,
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
                      validator: validatorImageUrl,
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
