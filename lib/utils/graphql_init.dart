import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/single_child_widget.dart';

class GraphQLInit extends SingleChildStatelessWidget {
  final Widget _child;
  GraphQLInit({@required child}): _child = child;

  @override
  Widget build(BuildContext context) {
    return buildWithChild(context, _child);
  }

  @override
  Widget buildWithChild(BuildContext context, Widget child) {
    final String host = '10.0.2.2'; // otherwise '127.0.0.1'
    final String graphqlEndpoint = 'http://$host:5000/graphql';
    final String subscriptionEndpoint =
        null; // can be 'ws://$host:3000/subscriptions'

    String uuidFromObject(Object object) {
      if (object is Map<String, Object>) {
        final String typeName = object['__typename'] as String;
        final String id = object['id'].toString();
        if (typeName != null && id != null) {
          return <String>[typeName, id].join('/');
        }
      }
      return null;
    }

    return GraphQLProvider(
        client: ValueNotifier<GraphQLClient>(
          GraphQLClient(
            cache: OptimisticCache(
              dataIdFromObject: uuidFromObject,
            ),
            link: subscriptionEndpoint == null
                ? HttpLink(uri: graphqlEndpoint)
                : HttpLink(uri: graphqlEndpoint)
              ..concat(WebSocketLink(
                url: subscriptionEndpoint,
                config: SocketClientConfig(
                  autoReconnect: true,
                  inactivityTimeout: Duration(seconds: 30),
                ),
              )), // without subscription
          ),
        ),
        child: child);
  }
}
