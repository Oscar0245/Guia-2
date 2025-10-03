import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const FrmEmpleado());
}

class FrmEmpleado extends StatefulWidget {
  const FrmEmpleado({super.key});

  @override
  State<FrmEmpleado> createState() => _FrmEmpleadoState();
}

class _FrmEmpleadoState extends State<FrmEmpleado> {
  final _formKey = GlobalKey<FormState>();

  final _txtIdentificacion = TextEditingController();
  final _txtNombre = TextEditingController();
  final _txtCelular = TextEditingController();
  final _txtEmail = TextEditingController();

  final _soloLetras = RegExp(r'^[A-Za-zÁÉÍÓÚáéíóúÑñ ]+$');
  final _emailRegex = RegExp(r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');

  String? _generoSeleccionado;

  void _limpiarCampos() {
    _txtIdentificacion.clear();
    _txtNombre.clear();
    _txtCelular.clear();
    _txtEmail.clear();
    setState(() {
      _generoSeleccionado = null;
    });
  }

  void _guardarEmpleado() {
    if (!_formKey.currentState!.validate()) return;

    _limpiarCampos();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Datos guardados correctamente")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("REGISTRO EMPLEADOS"),
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: _txtIdentificacion,
                  decoration: const InputDecoration(
                    labelText: 'Identificación',
                    hintText: "Máximo 10 dígitos",
                    prefixIcon: Icon(Icons.badge),
                    border: OutlineInputBorder(),
                    counterText: '',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "La identificación es obligatoria";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _txtNombre,
                  decoration: const InputDecoration(
                    labelText: "Nombre completo",
                    hintText: "Nombre(s) y apellido(s)",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  textCapitalization: TextCapitalization.words,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(_soloLetras),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "El nombre es obligatorio";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _generoSeleccionado,
                  decoration: const InputDecoration(
                    labelText: 'Género',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.wc),
                  ),
                  items: const [
                    DropdownMenuItem(
                        value: 'Masculino', child: Text('Masculino')),
                    DropdownMenuItem(
                        value: 'Femenino', child: Text('Femenino')),
                  ],
                  onChanged: (value) =>
                      setState(() => _generoSeleccionado = value),
                  validator: (value) =>
                      value == null ? 'Selecciona un género' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _txtCelular,
                  decoration: const InputDecoration(
                    labelText: "Número de celular",
                    hintText: "10 dígitos",
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "El número de celular es obligatorio";
                    }
                    if (value.length < 10) {
                      return "Debe tener 10 dígitos";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _txtEmail,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    hintText: "ejemplo@correo.com",
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters: [LengthLimitingTextInputFormatter(50)],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "El email es obligatorio";
                    }
                    if (!_emailRegex.hasMatch(value)) {
                      return 'Formato de correo no válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  onPressed: _guardarEmpleado,
                  label: const Text("Guardar"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
