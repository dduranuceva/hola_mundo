import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hola_mundo/models/categoria_fb.dart';
import 'package:hola_mundo/services/categoria_service.dart';
import 'package:hola_mundo/views/custom_drawer.dart';

class CategoriaFbListView extends StatelessWidget {
  const CategoriaFbListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categorías Firebase')),
      drawer: const CustomDrawer(),
      body: StreamBuilder<List<CategoriaFb>>(
        stream: CategoriaService.watchCategorias(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final categorias = snapshot.data!;
          return RefreshIndicator(
            onRefresh: () async {}, // No es necesario recargar
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: categorias.length,
              itemBuilder: (_, index) {
                final cat = categorias[index];
                return ListTile(
                  title: Text(cat.nombre),
                  subtitle: Text(cat.descripcion),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed:
                            () => context.push('/categoriasfb/edit/${cat.id}'),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          final confirmar = await showDialog<bool>(
                            context: context,
                            builder:
                                (ctx) => AlertDialog(
                                  title: const Text('Confirmar'),
                                  content: const Text(
                                    '¿Deseas eliminar esta categoría?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed:
                                          () => Navigator.pop(ctx, false),
                                      child: const Text('Cancelar'),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(ctx, true),
                                      child: const Text('Eliminar'),
                                    ),
                                  ],
                                ),
                          );
                          if (confirmar == true) {
                            await CategoriaService.deleteCategoria(cat.id);
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/categoriasfb/create'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
