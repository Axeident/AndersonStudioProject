using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LightDarkTransition : MonoBehaviour
{
    //Tracking where the player is and what rotation they are at (aka: where they are looking)
    private Transform player;

    //Is this script running, so we can track if the triggers are being used for this script
    private bool runningScript;

    ///The colors of the minimum and maximum
    public Color LightColor;
    public Color DarkColor;

    //Needed to know which objects/room particles spawn next
    private int optionChosen;

    //Used for the camera rotation - Used during scene coloration
    private float mathNumber;

    //Lists all walls and triggers of the current transition. Will be needed for color changing and room changing
    private List<Transform> triggers;

    //Simply put: What two transitions does this one lead to?
    public List<GameObject> LeadsTo;

    //Behind the scenes stuff. Change hold timer to allow for longer/shorter trigger holds.
    public float holdTimerInSeconds = 3f;
    private float heldTime = 0f;
    private bool waitingHold;

    // Start is called before the first frame update
    void Awake()
    {
        //Find what object has the main camera
        player = GameObject.FindGameObjectWithTag("MainCamera").transform;

        //This finds only the triggers in the scene. We want to track the triggers to make them disapear later on. 
        triggers = new List<Transform>();

        foreach (Transform sceneItem in transform)
        {
            if (sceneItem.CompareTag("TriggerOne") || sceneItem.CompareTag("TriggerTwo") || sceneItem.CompareTag("LoseItem"))
            {
                triggers.Add(sceneItem);
            }
        }

        //Once the game object this is attached to is "awoken," this script should be the focus
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
        }

        //Are we currently in a trigger? If so, we need to start counting to the predetermined time set.
        if (waitingHold)
        {
            //Just adds seconds since the last update call. Usually happens at a rapid pace.
            heldTime += Time.deltaTime;

            //Have we acheived our time goal?
            if (heldTime > holdTimerInSeconds)
            {
                if (optionChosen == 0)
                {
                    player.GetComponentInChildren<Camera>().backgroundColor = LightColor;
                }
                else
                {
                    player.GetComponentInChildren<Camera>().backgroundColor = DarkColor;
                }


                //If the scene transition stays, IE: objects spawned from the current transition, then only turn off the triggers
                //If the scene is not staying, IE: the color change transition, then the current transition needs to dissapear.
                //Later, we can add "Fade" mechanics as well.
                foreach (Transform turnOff in triggers)
                {
                    turnOff.gameObject.SetActive(false);
                }


                //Deactivate the script, so it doesn't cause strange issues later on in the engine.
                runningScript = false;


                //Make next scene activation based on choice made/trigger looked at. Should only be 2 options, if more are added,
                //will need to add more trigger tags as well. Fairly simple to do.
                LeadsTo[optionChosen].SetActive(true);
            }
        }
        //If we aren't counting down, then we need to make sure the timer is reset.
        else
        {
            heldTime = 0f;
        }

        //What is the Y axis (left/right) that we are looking at?
        float currentRotation = player.rotation.eulerAngles.y;

        //Start at a base number Zero, and add too it. This number needs to stay in a range of 0 to 1.
        mathNumber = 0f;

        //This gives a 360 view based on the viewers Y-Axis. We are starting at a "grey," so straight forward
        //and straight back should be set to 0.5 (direct middle of 0 and 1) to blend the min and max colors.
        //Turning one direction will lead the counter to Zero, and the opposite direction to One. If the viewer
        //starts looking behind themselves, the color should fade back to neutral instead of going immediately from
        //one extreme to another.
        if (currentRotation >= 0 && currentRotation < 75)
        {
            mathNumber = 0.5f + (currentRotation / 180);
        }
        else if (currentRotation >= 75 && currentRotation <= 105)
        {
            mathNumber = 1;
        }
        else if (currentRotation >= 255 && currentRotation <= 285)
        {
            mathNumber = 0;
        }
        else if (currentRotation > 105 && currentRotation < 180)
        {
            mathNumber = 1 - ((currentRotation - 90) / 180);
        }
        else if (currentRotation >= 180 && currentRotation < 255)
        {
            mathNumber = (270 - currentRotation) / 180;
        }
        else if (currentRotation >= 285 && currentRotation < 360)
        {
            mathNumber = (currentRotation - 270) / 180;
        }

        //This finds each wall in the scene (already deteremined when the transition is awoken) and
        //Modifies the color based on the direction the viewer is facing, and blends the min and max colors
        //accordingly, for a smooth transition from "Light to Dark."
        player.GetComponentInChildren<Camera>().backgroundColor = Color.Lerp(LightColor, DarkColor, mathNumber);
    }
}
