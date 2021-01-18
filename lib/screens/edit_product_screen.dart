import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  final EditProductArguments editProductarguments;

  const EditProductScreen({@required this.editProductarguments});

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class EditProductArguments {
  final String productId;

  EditProductArguments({@required this.productId});
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _isInit = true;
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
  void didChangeDependencies() {
    if (_isInit) {
      final args = widget.editProductarguments;
      if (args != null) {
        _editedProduct = Provider.of<ProductsProvider>(context, listen: false).findById(args.productId);

        _titleController.text = _editedProduct.title;
        _descriptionController.text = _editedProduct.description;
        _priceController.text = _editedProduct.price.toString();
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
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

    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    if (_editedProduct.id != null) {
      Provider.of<ProductsProvider>(context, listen: false).updateProduct(_editedProduct.id, _editedProduct);
    } else {
      //id is a final variable so it can't be pass here and change it
      Provider.of<ProductsProvider>(context, listen: false).addProduct(_editedProduct);
    }

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

  void onSavedImageUrl(String value) {
    _editedProduct = Product(
      title: _editedProduct.title,
      price: _editedProduct.price,
      description: _editedProduct.description,
      imageUrl: value,
      id: _editedProduct.id,
      isFavorite: _editedProduct.isFavorite,
    );
  }

  void onSavedDescription(String value) {
    _editedProduct = Product(
      title: _editedProduct.title,
      price: _editedProduct.price,
      description: value,
      imageUrl: _editedProduct.imageUrl,
      id: _editedProduct.id,
      isFavorite: _editedProduct.isFavorite,
    );
  }

  void onSavedPrice(String value) {
    _editedProduct = Product(
      title: _editedProduct.title,
      price: double.parse(value),
      description: _editedProduct.description,
      imageUrl: _editedProduct.imageUrl,
      id: _editedProduct.id,
      isFavorite: _editedProduct.isFavorite,
    );
  }

  void onSavedTitle(String value) {
    _editedProduct = Product(
      title: value,
      price: _editedProduct.price,
      description: _editedProduct.description,
      imageUrl: _editedProduct.imageUrl,
      id: _editedProduct.id,
      isFavorite: _editedProduct.isFavorite,
    );
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
            onPressed: _saveForm,
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
                controller: _titleController,
                validator: validatorTitle,
                onSaved: onSavedTitle,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) => focusScope.requestFocus(_descriptionFocusNode),
                controller: _priceController,
                validator: validatorPrice,
                onSaved: onSavedPrice,
              ),
              TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionFocusNode,
                  controller: _descriptionController,
                  validator: validatorDescription,
                  onSaved: onSavedDescription),
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
                        onSaved: onSavedImageUrl),
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
