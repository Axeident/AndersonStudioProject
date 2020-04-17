using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WeAreDone : MonoBehaviour
{
    public float HowLongTilStart;
    public GameObject menus;
    private float makeTime;
    private bool isMoving = false;

    //Menu delay timer
    public float MenuDelayTimer;
    private float menuTimer;
    private bool startMenuTimer;
    
    void Awake()
    {
        makeTime = 0f;
        isMoving = true;
        startMenuTimer = false;
    }

    // Update is called once per frame
    void Update()
    {
        if (isMoving)
        {
            makeTime += Time.deltaTime;
            if (makeTime >= HowLongTilStart)
            {
                gameObject.GetComponentInParent<PanAway>().StartJourney();
                isMoving = false;
                startMenuTimer = true;
            }
        }
        else
            makeTime = 0f;

        if (startMenuTimer)
        {
            menuTimer += Time.deltaTime;

            if (menuTimer >= MenuDelayTimer)
            {
                menus.SetActive(true);
                startMenuTimer = false;
            }
        }
        else
            menuTimer = 0f;
    }
}
