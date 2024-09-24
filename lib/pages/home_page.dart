import 'package:bloc_pitfall_example/application/bloc/pitfall_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter(BuildContext context) {
    context.read<PitfallBloc>().add(PitfallActionEvent());
  }

  void _failedNetworkCall(BuildContext context) {
    context.read<PitfallBloc>().add(PitfallActionEvent(actionNetwork: true));
  }

  void _failedMethodChannelCall(BuildContext context,
      {required bool withTimeout}) {
    context.read<PitfallBloc>().add(PitfallActionEvent(
          actionNativeCall: true,
          withTimeOut: withTimeout,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('BLoC Pitfall Example'),
      ),
      body: BlocProvider(
        create: (context) => PitfallBloc(),
        child: Center(
          child: Builder(builder: (innerContext) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => _failedNetworkCall(innerContext),
                  child: const Text('Failed network event'),
                ),
                ElevatedButton(
                  onPressed: () => _failedMethodChannelCall(
                    innerContext,
                    withTimeout: false,
                  ),
                  child: const Text('Failed MethodChannel event'),
                ),
                ElevatedButton(
                  onPressed: () => _failedMethodChannelCall(
                    innerContext,
                    withTimeout: true,
                  ),
                  child: const Text('Failed MethodChannel event with timeout'),
                ),
                const SizedBox(height: 100),
                const Text(
                  'You have pushed the button this many times:',
                ),
                BlocBuilder<PitfallBloc, PitfallState>(
                  builder: (context, state) {
                    return Text(
                      '${state.value}',
                      style: Theme.of(context).textTheme.headlineMedium,
                    );
                  },
                ),
                ElevatedButton(
                  onPressed: () => _incrementCounter(innerContext),
                  child: const Icon(Icons.add),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
