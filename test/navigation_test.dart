/// Author: Mason Powell
/// Student No. 170256018

import 'package:test/test.dart';
import 'package:csc2022_app/algorithm/navigation.dart';
import 'package:csc2022_app/algorithm/node.dart';
import 'package:csc2022_app/algorithm/graph.dart';
import 'dart:collection';


void main() {
  
  group('Graph',() {
    int expFloorNum = 1;

    Graph g = Graph();
    Graph gF;

    test('get floorNumber', (){
      gF = Graph.floor(expFloorNum);
      int actFloorNum = gF.floorNumber;

      expect(expFloorNum, actFloorNum);
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

      expect(distCheck, true);
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

      expect(pathCheck, true);

    });
  });
}