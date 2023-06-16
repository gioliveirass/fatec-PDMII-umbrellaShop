import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final theme = ThemeData();
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carrinho de compras',
      home: LoginPage(),
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.pink
        )
      )
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _login = TextEditingController();
  final TextEditingController _password = TextEditingController();

  Color textColor = Colors.black; 
  Color textColorWarning = Colors.grey;
  Color borderColor = Colors.grey;

  String _result = "";
  bool sent = false;

  void _send() {
    String login = _login.text;
    String password = _password.text;

    void changeTextColor(Color newColor) {
      setState(() {
        textColor = newColor;
      });
    }

    void changeBorderColor(Color newColor) {
      setState(() {
        borderColor = newColor;
      });
    }

    void changeSent(bool wasSent) {
      setState(() {
        sent = wasSent;
      });
    }

    setState(() {
      if (login == "") {
        changeTextColor(Colors.red);
        changeBorderColor(Colors.red);
        _result = "Insira seu login";
      } else if (password == "") {
        changeTextColor(Colors.red);
        changeBorderColor(Colors.red);
        _result = "Insira sua senha";
      } else {
        Navigator.push( context,
          MaterialPageRoute(builder: (context) => ProductsPage()),
        );
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16.0), 
            Image(
              image: NetworkImage('https://raw.githubusercontent.com/gioliveirass/fatec-PDMII-market/main/assets/logo.png'),
            ),
            const SizedBox(height: 16.0), 
            SizedBox(
              width: 300,
              child: TextField(
                controller: _login, 
                keyboardType: TextInputType.text, 
                decoration: InputDecoration(
                  hintText: 'Login',
                  prefixIcon: const Icon(Icons.account_circle_outlined), 
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: borderColor), 
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  )
                )
              )
            ),
            const SizedBox(height: 16.0), 
            SizedBox(
              width: 300,
              child: TextField(
                controller: _password, 
                keyboardType: TextInputType.text, 
                decoration: InputDecoration(
                  hintText: 'Senha',
                  prefixIcon: const Icon(Icons.account_circle_outlined), 
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: borderColor), 
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  )
                )
              )
            ),
            const SizedBox(height: 16.0), 
            !sent
             ? SizedBox(
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _send,
                    child: const Text('Enviar'),
                  ),
                ]
              ),
             ) 
             : const SizedBox.shrink(),
            const SizedBox(height: 16.0),
            Text(
              _result,
              style: TextStyle(fontSize: 24.0, color: textColor),
            ),
          ]
        ),
      )
    );
  }
}

class ProductsPage extends StatefulWidget {
  @override
  ProductsPageState createState() => ProductsPageState();
}

class ProductsPageState extends State<ProductsPage> {
  final List<String> items = [
    "The Sims 4", 
    'Stardew Valley', 
    'Dark Souls', 
    'The Last of Us',
    'Shadow Of The Colossus',
    'Pokemon Shield',
    'Crash Bandicoot'
  ];

  final TextEditingController _amount = TextEditingController();

  Color textColor = Colors.black; 
  Color textColorWarning = Colors.grey;
  Color borderColor = Colors.grey;

  String _selectItem = "";
  String _selectAmount = "";
  String _result = "";
  bool sent = false;

  void changeSelectedItem(String e) {
    setState(() {
      _selectItem = e;
    });
  }

  void _send() {
    String amount = _amount.text;
    String selectItem = _selectItem;

    void changeTextColor(Color newColor) {
      setState(() {
        textColor = newColor;
      });
    }

    void changeBorderColor(Color newColor) {
      setState(() {
        borderColor = newColor;
      });
    }

    void changeSent(bool wasSent) {
      setState(() {
        sent = wasSent;
      });
    }

    setState(() {
      if (amount == "" || selectItem == "") {
        changeTextColor(Colors.red);

        if (amount == "") {
          _result = "Necessário informar a quantidade";
        } else if (selectItem == "") {
          _result = "Necessário selecionar um produto";
        }
        
        changeBorderColor(Colors.red);
      } else {
        changeSent(true);
        changeTextColor(Colors.red);
        changeBorderColor(Colors.grey);

        _result = "Enviado com sucesso.";
        _selectItem = selectItem;
        _selectAmount = amount;

        Navigator.push( context,
          MaterialPageRoute(builder: (context) => PurchaseDetailsPage(amount: _selectAmount, product: _selectItem)),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleção de produtos'),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.max,
           children: [
            const Divider(),
            const SizedBox(height: 16.0),
            const Text(
              'Produtos',
              style: TextStyle(fontSize: 24.0, color: Colors.blue),
            ),
            const SizedBox(height: 16.0),
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                 itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(items[index]),
                    onTap: () {
                      print('Tapped on Item ${index + 1}');
                      changeSelectedItem(items[index]);
                    }
                  );
                 }
              )
            ),
            const SizedBox(height: 16.0),
             const Text(
              'Quantidade',
              style: TextStyle(fontSize: 24.0, color: Colors.blue),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: 300,
              child: TextField(
                 controller: _amount,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Quantidade',
                    prefixIcon: const Icon(Icons.account_circle_outlined),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: borderColor),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    )
                  )
              )
            ),
            const SizedBox(height: 16.0),
            !sent
              ? SizedBox(
                  width: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _send,
                        child: const Text('Enviar'),
                      )
                    ]
                  ),
                )
              : const SizedBox.shrink(),
              const SizedBox(height: 16.0),
              Text(
                '$_result',
                style: TextStyle(fontSize: 24.0, color: textColor),
              ),
           ]
        )
      )
    );
  }
}

class PurchaseDetailsPage extends StatefulWidget {
  final String product; 
  final String amount; 

  const PurchaseDetailsPage(
    {
      Key? key, 
      required this.product, 
      required this.amount,
    }
  ) : super(key: key);

  @override
  PurchaseDetailsPageState createState() => PurchaseDetailsPageState(product: product, amount: amount);
}

class PurchaseDetailsPageState extends State<PurchaseDetailsPage> {
  final String product; 
  final String amount; 

  PurchaseDetailsPageState({required this.product, required this.amount});

  void _send() {
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => ConfirmPage()),
    );
  }

  void _cancel() {
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => ProductsPage()),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detalhes da compra")),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 100.0),
            Text("Produto selecionado: " + product, style:  const TextStyle(fontSize: 24.0, color: Colors.black)),
            Text("Quantidade: " + amount, style:  const TextStyle(fontSize: 24.0, color: Colors.black)),
            const SizedBox(height: 100.0),
            SizedBox(
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _cancel,
                    child: const Text('Voltar'),
                  ),
                  ElevatedButton(
                    onPressed: _send,
                    child: const Text('Enviar'),
                  )
                ]
              ),
             ) 
          ]
        )
      )
    );
  }
}

class ConfirmPage extends StatefulWidget {
  @override
  ConfirmPageState createState() => ConfirmPageState();
}

class ConfirmPageState extends State<ConfirmPage> {
  Color textColor = Colors.black; 

  _cancel() {
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => ProductsPage()),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16.0), 
            Image(
              image: NetworkImage('https://raw.githubusercontent.com/gioliveirass/fatec-PDMII-market/main/assets/logo.png'),
            ),
            const SizedBox(height: 16.0), 
            Text(
              'Pedido confirmado!',
              style: TextStyle(fontSize: 24.0, color: textColor),
            ),
            const SizedBox(height: 16.0), 
            ElevatedButton(
              onPressed: _cancel,
              child: const Text('Voltar'),
            ),
          ]
        ),
      )
    );
  }
}