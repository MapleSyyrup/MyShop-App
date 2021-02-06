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

///Class for arguments that the navigator needs
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
  var _editedProduct = Product(
    id: null,
    title: '',
    price: 0,
    description: '',
    imageUrl: '',
  );

  ///Called when there is a state created
  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  ///Called when there are changes in State
  @override
  void didChangeDependencies() {
    final args = widget.editProductarguments;
    if (args != null) {
      _editedProduct = Provider.of<ProductsProvider>(context, listen: false).findById(args.productId);
      _titleController.text = _editedProduct.title;
      _titleController.selection = TextSelection.fromPosition(TextPosition(offset: _titleController.text.length));
      _descriptionController.text = _editedProduct.description;
      _descriptionController.selection =
          TextSelection.fromPosition(TextPosition(offset: _descriptionController.text.length));
      _priceController.text = _editedProduct.price.toString();
      _priceController.selection = TextSelection.fromPosition(TextPosition(offset: _priceController.text.length));
      _imageUrlController.text = _editedProduct.imageUrl;
      _imageUrlController.selection = TextSelection.fromPosition(TextPosition(offset: _imageUrlController.text.length));
    }
    super.didChangeDependencies();
  }

  ///Removes an object if it is not needed
  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();

    super.dispose();
  }

  ///Shows the image URL even if the product details are not yet saved
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

  ///Function for saving the product details
  void _saveForm() {
    final isValid = _formKey.currentState.validate();

    ///Id the inputs of the user are not valid, it will not be saved
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();

    final product = Product(
      id: _editedProduct.id ?? DateTime.now().toString(),
      title: _titleController.text,
      price: double.parse(_priceController.text),
      description: _descriptionController.text,
      imageUrl: _imageUrlController.text,
    );
    final provider = Provider.of<ProductsProvider>(context, listen: false);

    ///If the productId is existing, the product will update, if the productId is not existing, a new product is added
    _editedProduct.id != null ? provider.updateProduct(product) : provider.addProduct(product);

    ///Closes the edit product screen when the details are saved
    Navigator.of(context).pop();
  }

  ///Validator condition for ImageUrl
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

  ///Validator condition for Description
  String validatorDescription(String value) {
    if (value.isEmpty) {
      return 'Please enter a description';
    }
    if (value.length < 10) {
      return 'Please enter more than 10 characters';
    }
    return null;
  }

  ///Validator condition for Price
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

  ///Validator condition for Title
  String validatorTitle(String value) {
    return value.isEmpty ? 'Error description example' : null;
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
