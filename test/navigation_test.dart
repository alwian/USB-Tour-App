/// Author: Mason Powell
/// Student No. 170256018

import 'package:test/test.dart';
import 'package:csc2022_app/algorithm/navigation.dart';
import 'package:csc2022_app/algorithm/node.dart';
import 'package:csc2022_app/algorithm/graph.dart';
import 'dart:collection';


void main() {
  Node n;

  group('Node', () {
    test('Node() get name', () {
      String expName = "test";
      n = Node(expName);

      String actName = n.name;

      expect(actName, expName);
    });

    test('Node.fromDB() get name', () {
      String expName = "test";
      n = Node.fromDB(expName, null, null);

      String actName = n.name;

      expect(actName, expName);
    });

    test('Node.fromDB() get coordsX', () {
      double expCoordsX = 1.1;
      n = Node.fromDB(null, expCoordsX, null);

      double actCoordsX = n.coordsX;

      expect(actCoordsX, expCoordsX);
    });

    test('Node.fromDB() get coordsY', () {
      double expCoordsY = 1.1;
      n = Node.fromDB(null, null, expCoordsY);

      double actCoordsY = n.coordsY;

      expect(actCoordsY, expCoordsY);
    });

    test('addDestination valid Node', () {
      n = Node("test");
      Node adjNode = Node("test2");
      int testDistance = 100;
      n.addDestination(adjNode, testDistance);

      expect(n.adjacentNodes, isNotEmpty);
    });

    test('addDestination invalid Node', () {
      n = Node("test");
      int testDistance = 100;

      expect(() => n.addDestination(n, testDistance), throwsArgumentError);
    });

    test('addDestination valid distance', () {
      n = Node("test");
      Node adjNode = Node('test2');
      int expDistance = 100;
      n.addDestination(adjNode, expDistance);

      int actDistance = n.adjacentNodes[adjNode];

      expect(actDistance, expDistance);
    });

    test('addDestination invalid distance', () {
      n = Node("test");
      Node adjNode = Node('test2');
      int expDistance = -1;

      expect(() => n.addDestination(adjNode, expDistance), throwsArgumentError);
    });

    test('toString', () {
      String expStringRep = "test";
      n = Node(expStringRep);

      String actStringRep = n.toString();

      expect(actStringRep, expStringRep);
    });

    test('copy', () {
      bool equal = false;

      n = Node("test");
      Node testNode = n.copy();

      if(n == testNode) {
        equal = true;
      }

      expect(equal, isFalse);
    });

  });

  group('Graph',() {
    Graph g;

    test('get floorNumber', (){
      int expFloorNum = 1;
      g = Graph.floor(expFloorNum);
      int actFloorNum = g.floorNumber;

      expect(actFloorNum, expFloorNum);
    });

    test('addNodes valid', () {
      g = Graph();
      Node expNode = Node("expNode");
      g.addNode(expNode);

      Node actNode = g.nodes.first;

      expect(actNode, expNode);
    });

    test('addNodes invalid', () {
      g = Graph();
      Node testNode;

      g.addNode(testNode);

      expect(g.nodes, isEmpty);
    });
  });

  group('Nav', ()
  {
    Node a = new Node("a");
    Node b = new Node("b");
    Node c = new Node("c");
    Node d = new Node("d");
    Node e = new Node("e");
    Node f = new Node("f");

    a.addDestination(b, 10);
    a.addDestination(c, 15);

    b.addDestination(d, 12);
    b.addDestination(f, 15);

    c.addDestination(e, 10);

    d.addDestination(e, 2);
    d.addDestination(f, 1);

    f.addDestination(e, 5);

    Graph graph = new Graph();

    graph.addNode(a);
    graph.addNode(b);
    graph.addNode(c);
    graph.addNode(d);
    graph.addNode(e);
    graph.addNode(f);

    graph = Navigation.calculateShortestPathFromSource(graph, a);

    test('shortestPathFromSource', () {

      bool distCheck = false;
      for (Node u in graph.nodes) {
        switch (u.name) {
          case "a":
            if (u.distance == 0) {
              distCheck = true;
              break;
            } else {
              distCheck = false;
              break;
            }
            break;

          case "b":
            if (u.distance == 10) {
              distCheck = true;
              break;
            } else {
              distCheck = false;
              break;
            }
            break;

          case "c":
            if (u.distance == 15) {
              distCheck = true;
              break;
            } else {
              distCheck = false;
              break;
            }
            break;

          case "d":
            if (u.distance == 22) {
              distCheck = true;
              break;
            } else {
              distCheck = false;
              break;
            }
            break;

          case "e":
            if (u.distance == 24) {
              distCheck = true;
              break;
            } else {
              distCheck = false;
              break;
            }
            break;

          case "f":
            if (u.distance == 23) {
              distCheck = true;
              break;
            } else {
              distCheck = false;
              break;
            }
            break;

          default:
            distCheck = false;
            break;
        }
      }

      expect(distCheck, isTrue);
    });

    test('pathToTargetNodeAToNodeF', () {
      Queue<Node> expPath = new Queue();
      Queue<Node> actPath = new Queue();

      expPath.addLast(e);
      expPath.addLast(d);
      expPath.addLast(b);
      expPath.addLast(a);

      actPath = Navigation.pathToTarget(graph,a,e);

      bool pathCheck = false;

      for(int i = 0; i < actPath.length; i++) {
        if(actPath.removeLast().name == expPath.removeLast().name) {
          pathCheck = true;
        } else {
          pathCheck = false;
          break;
        }
      }

      expect(pathCheck, isTrue);

    });
  });
}