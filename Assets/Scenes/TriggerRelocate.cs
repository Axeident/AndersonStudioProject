using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TriggerRelocate : MonoBehaviour
{
    public List<Transform> moveLocations;
    public float activateTimer;
    public int howManyObjects = 3;

    private int objectsMoved;
    private int[] triggerCount;

    private Transform player;

    private bool waitingHold;
    private int optionChosen;
    private float timerCount;

    private List<Transform> triggerOnes;
    private List<Transform> triggerTwos;

    public List<GameObject> LeadsTo;

    // Start is called before the first frame update
    void Start()
    {
        objectsMoved = 0;
        triggerCount = new int[2] { 0, 0 };

        player = GameObject.FindGameObjectWithTag("MainCamera").transform;

        triggerOnes = new List<Transform>();
        triggerTwos = new List<Transform>();

        foreach (Transform sceneItem in transform)
        {
            if (sceneItem.CompareTag("TriggerOne"))
            {
                triggerOnes.Add(sceneItem);
            }
            else if(sceneItem.CompareTag("TriggerTwo"))
            {
                triggerTwos.Add(sceneItem);
            }
        }
    }
    

    // Update is called once per frame
    void Update()
    {
        RaycastHit hit;
        waitingHold = false;

        if (Physics.Raycast(player.position, player.TransformDirection(Vector3.forward), out hit, Mathf.Infinity))
        {
            if (hit.transform.gameObject.CompareTag("TriggerOne") && hit.transform.GetComponent<ObjectMoves>().CanIMove())
            {
                waitingHold = true;
                optionChosen = 0;
            }
            if (hit.transform.gameObject.CompareTag("TriggerTwo") && hit.transform.GetComponent<ObjectMoves>().CanIMove())
            {
                waitingHold = true;
                optionChosen = 1;
            }
        }

        if(waitingHold)
        {
            timerCount += Time.deltaTime;
            if(timerCount >= activateTimer)
            {
                hit.transform.GetComponent<ObjectMoves>().StartFlight(moveLocations[objectsMoved]);
                ++objectsMoved;
                ++triggerCount[optionChosen];
            }
        }
        else
        {
            timerCount = 0f;
        }

        if(triggerCount[0] >= howManyObjects)
        {
            foreach(Transform goodBye in triggerTwos)
            {
                goodBye.gameObject.SetActive(false);
            }

            LeadsTo[0].SetActive(true);
        }
        else if(triggerCount[1] >= howManyObjects)
        {
            foreach (Transform goodBye in triggerOnes)
            {
                goodBye.gameObject.SetActive(false);
            }

            LeadsTo[1].SetActive(true);
        }
    }
}
