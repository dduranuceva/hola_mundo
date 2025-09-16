import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hola_mundo/models/categoria_fb.dart';
import 'package:hola_mundo/services/categoria_service.dart';

class CategoriaFbFormView extends StatefulWidget {
  final String? id;

  const CategoriaFbFormView({super.key, this.id});

  @override
  State<CategoriaFbFormView> createState() => _CategoriaFbFormViewState();
}

class _CategoriaFbFormViewState extends State<CategoriaFbFormView> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _descripcionController = TextEditingController();
  bool _camposInicializados = false;

  Future<void> _guardar({String? id}) async {
    if (_formKey.currentState!.validate()) {
      final categoria = CategoriaFb(
        id: id ?? '',
        nombre: _nombreController.text,
        descripcion: _descripcionController.text,
      );

      if (widget.id == null) {
        await CategoriaService.addCategoria(categoria);
      } else {
        await CategoriaService.updateCategoria(categoria);
      }

      if (mounted) context.pop();
    }
  }

  void _inicializarCampos(CategoriaFb categoria) {
    if (_camposInicializados) return;
    _nombreController.text = categoria.nombre;
    _descripcionController.text = categoria.descripcion;
    _camposInicializados = true;
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool esNuevo = widget.id == null;

    return Scaffold(
      appBar: AppBar(
        title: Text(esNuevo ? 'Crear Categoría' : 'Editar Categoría'),
      ),
      body:
          esNuevo
              ? _buildFormulario(context, id: null)
              : StreamBuilder<CategoriaFb?>(
                stream: CategoriaService.watchCategoriaById(widget.id!),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final categoria = snapshot.data!;
                  _inicializarCampos(categoria);
                  return _buildFormulario(context, id: categoria.id);
                },
              ),
    );
  }

  Widget _buildFormulario(BuildContext context, {required String? id}) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: 'Nombre'),
              validator:
                  (value) =>
                      value == null || value.isEmpty ? 'Requerido' : null,
            ),
            TextFormField(
              controller: _descripcionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
              validator:
                  (value) =>
                      value == null || value.isEmpty ? 'Requerido' : null,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => _guardar(id: id),
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
