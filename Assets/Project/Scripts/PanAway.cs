using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PanAway : MonoBehaviour
{
    public bool startPan;
    private float startTimer;
    private float journeyDistance;

    public float moveSpeed = 1f;


    public Transform moveLocation;
    private Transform startLocation;

    //Menu Stuff
    public GameObject menus;
    public float MenuDelayTimer;
    private float menuTimer;
    public bool startMenuTimer;

    void Start()
    {
        startPan = false;
        startLocation = transform;

        menus.SetActive(false);
        startMenuTimer = false;
        menuTimer = 0.0f;
    }

    public void StartJourney()
    {
        startPan = true;
        startTimer = Time.time;
        journeyDistance = Vector3.Distance(moveLocation.position, startLocation.position);
        startMenuTimer = true;
    }

    // Update is called once per frame
    void Update()
    {
        if (startPan)
        {
            float distanceCovered = (Time.time - startTimer) * moveSpeed;

            float distanceSoFar = distanceCovered / journeyDistance;

            transform.position = Vector3.Lerp(startLocation.position, moveLocation.position, distanceSoFar);

            if (distanceCovered >= journeyDistance)
            {
                startPan = false;                
            }
        }

        if(startMenuTimer)
        {
            menuTimer += Time.deltaTime;

            if(menuTimer >= MenuDelayTimer)
            {
                menus.SetActive(true);
                startMenuTimer = false;
            }
        }
    }
}
