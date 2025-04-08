import 'package:go_router/go_router.dart';
import 'package:hola_mundo/views/auth/login_page.dart';
import 'package:hola_mundo/views/auth/register_page.dart';
import 'package:hola_mundo/views/ciclo_vida/ciclo_vida_screen.dart';
import 'package:hola_mundo/views/establecimientos/establecimiento_create_view.dart';
import 'package:hola_mundo/views/establecimientos/establecimiento_edit_view.dart';
import 'package:hola_mundo/views/establecimientos/establecimientos_list_view.dart';
import 'package:hola_mundo/views/future/future_view.dart';
import 'package:hola_mundo/views/home_view.dart';
import 'package:hola_mundo/views/isolate/isolate_view.dart';
import 'package:hola_mundo/views/paso_parametros/detalle_screen.dart';
import 'package:hola_mundo/views/paso_parametros/paso_parametros_screen.dart';
import 'package:hola_mundo/views/pokemons/pokemon_detail_view.dart';
import 'package:hola_mundo/views/pokemons/pokemon_list_view.dart';
import 'package:hola_mundo/views/profile_view.dart';
import 'package:hola_mundo/views/settings_view.dart';
import 'package:hola_mundo/views/timer/timer_view.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeView(), // Usa HomeView
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsView(), // Usa SettingsView
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileView(), // Usa ProfileView
    ),

    // Rutas para el paso de parámetros
    GoRoute(
      path: '/paso_parametros',
      builder: (context, state) => const PasoParametrosScreen(),
    ),
    // !Ruta para el detalle con parámetros
    GoRoute(
      path:
          '/detalle/:parametro/:metodo', //la ruta recibe dos parametros los " : " indican que son parametros
      builder: (context, state) {
        //*se capturan los parametros recibidos
        // declarando las variables parametro y metodo
        // es final porque no se van a modificar
        final parametro = state.pathParameters['parametro']!;
        final metodo = state.pathParameters['metodo']!;
        return DetalleScreen(parametro: parametro, metodoNavegacion: metodo);
      },
    ),
    //!Ruta para el ciclo de vida
    GoRoute(
      path: '/ciclo_vida',
      builder: (context, state) => const CicloVidaScreen(),
    ),
    //!Ruta para el demo de Future
    GoRoute(
      path: '/future',
      name: 'future',
      builder: (context, state) => const FutureView(),
    ),
    //!Ruta para el demo de Timer
    GoRoute(
      path: '/timer',
      name: 'timerView',
      builder: (context, state) => const TimerView(),
    ),

    //!Ruta para el demo de Isolate
    GoRoute(
      path: '/isolate', //*ruta para el demo de Isolate
      name: 'isolate', //*nombre de la ruta
      builder: (context, state) => const IsolateView(),
    ),
    //!Rutas para el manejo de Pokémon
    GoRoute(
      path: '/pokemon',
      name: 'pokemons',
      builder: (context, state) => const PokemonListView(),
    ),
    GoRoute(
      path: '/pokemon/:name',
      name: 'pokemonDetail',
      builder:
          (context, state) =>
              PokemonDetailView(name: state.pathParameters['name']!),
    ),
    //!Rutas para el manejo de Establecimientos
    //!Ruta para la lista de establecimientos
    GoRoute(
      path: '/establecimientos',
      name: 'establecimientos',
      builder: (context, state) => const EstablecimientosListView(),
    ),
    //!Ruta para editar de un establecimiento
    GoRoute(
      path: '/establecimientos/edit/:id',
      builder: (context, state) {
        //*se captura el id del establecimiento
        final id = int.parse(state.pathParameters['id']!);
        return EstablecimientoEditView(id: id);
      },
    ),
    //!Ruta para crear un nuevo establecimiento
    GoRoute(
      path: '/establecimientos/create',
      builder: (context, state) => const EstablecimientoCreateView(),
    ),

    //!Ruta para autenticacion
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterPage(),
    ),
  ],
);
