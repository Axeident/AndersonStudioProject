using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FloorController : MonoBehaviour
{
    //Needed to track the player's look direction
    private Transform player;

    //Is this script running, so we can track if the triggers are being used for this script
    private bool runningScript;

    //Needed to know which objects/room particles spawn next
    private int optionChosen;

    //Floor Objects for scene
    public GameObject IndustrialFloor;
    public GameObject NaturalFloor;

    //Lists all walls and triggers of the current transition. Will be needed for color changing and room changing
    private List<Transform> triggers;

    //Simply put: What two transitions does this one lead to?
    public List<GameObject> LeadsTo;

    //Behind the scenes stuff. Change hold timer to allow for longer/shorter trigger holds.
    public float holdTimer = 3f;
    private float heldTime = 0f;
    private bool waitingHold;

    // Start is called before the first frame update
    void Awake()
    {
        player = GameObject.FindGameObjectWithTag("MainCamera").transform;

        if (IndustrialFloor != null)
            IndustrialFloor.SetActive(false);
        if (NaturalFloor != null)
            NaturalFloor.SetActive(false);


        //This finds only the triggers in the scene. If the transition stays (basically, we are adding to the scene, not replacing
        //it), we want to track the triggers to make them disapear later on.
        triggers = new List<Transform>();

        foreach (Transform sceneItem in transform)
        {
            if (sceneItem.CompareTag("TriggerOne") || sceneItem.CompareTag("TriggerTwo") || sceneItem.CompareTag("LoseItem"))
            {
                triggers.Add(sceneItem);
            }
        }


        runningScript = true;
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        if (runningScript)
        {
            //Always reset values before checking if they are still true. This way, we don't have to make a "are we not
            //looking at something," and save half the work load.
            waitingHold = false;

            //Where are we looking, and are there any triggers in that direction?
            RaycastHit hit;

            if (Physics.Raycast(player.position, player.TransformDirection(Vector3.forward), out hit, Mathf.Infinity))
            {
                //If there are triggers, what are we looking at?
                if (hit.transform.gameObject.CompareTag("TriggerOne"))
                {
                    //If we are hitting a trigger, then the system should know to start a countdown
                    waitingHold = true;
                    //track numerically what trigger we are looking at
                    optionChosen = 0;
                }
                if (hit.transform.gameObject.CompareTag("TriggerTwo"))
                {
                    waitingHold = true;
                    optionChosen = 1;
                }
            }

            //Are we currently in a trigger? If so, we need to start counting to the predetermined time set.
            if (waitingHold)
            {
                //Just adds seconds since the last update call. Usually happens at a rapid pace.
                heldTime += Time.deltaTime;

                //Have we acheived our time goal?
                if (heldTime > holdTimer)
                {
                    foreach (Transform turnOff in triggers)
                    {
                        turnOff.gameObject.SetActive(false);
                    }

                    if (optionChosen == 0)
                        IndustrialFloor.SetActive(true);
                    if (optionChosen == 1)
                        NaturalFloor.SetActive(true);

                    //Deactivate the script, so it doesn't cause strange issues later on in the engine.
                    runningScript = false;

                    //Make next scene activation based on choice made/trigger looked at. Should only be 2 options, if more are added,
                    //will need to add more trigger tags as well. Fairly simple to do.
                    LeadsTo[optionChosen].SetActive(true);
                }
            }
            //If we are counting down, then we need to make sure the timer is reset.
            else
            {
                heldTime = 0f;
            }
        }
    }
}
