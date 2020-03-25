using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HighlightOption : MonoBehaviour
{
    public bool shakeSelection;
    public bool glareSelection;

    private bool startSelection;
    private float holdTime;
    private float hasBeenHeld;

    public float lerpProgress;

    public Color ColorStart;
    public Color ColorEnd;

    private bool isRocked;
    private float RotationStart;
    private float RotationEnding;

    void Awake()
    {
        hasBeenHeld = 0f;

        if(shakeSelection)
        {
            RotationStart = 0.0f;
            RotationEnding = 15.0f;
        }

        if (transform.childCount < 1)
        {
            ColorStart = Color.white;
            ColorEnd = Color.grey;
        }
        else
        {
            ColorStart = GetComponentInChildren<MeshRenderer>().material.color;
            ColorEnd = ColorStart / 2;
        }

        holdTime = GetComponent<TriggerRelocate>().activateTimer;
    }

    public void ActivateTouch()
    {
        startSelection = true;
    }

    // Update is called once per frame
    void Update()
    {
        if(startSelection)
        {
            hasBeenHeld += Time.deltaTime;

            lerpProgress = hasBeenHeld / holdTime;

            if (shakeSelection)
            {
                float roter = Mathf.Lerp(RotationStart, RotationEnding, lerpProgress);

                if(isRocked)
                {
                    transform.Rotate(roter, roter, roter);
                    isRocked = false;
                }
                else
                {
                    transform.Rotate(-roter, -roter, -roter);
                    isRocked = true;
                }

            }

            if(glareSelection)
            {
                GetComponentInChildren<MeshRenderer>().material.color = Color.Lerp(ColorStart, ColorEnd, lerpProgress);
            }

            startSelection = false;
        }
        else
        {
            hasBeenHeld = 0f;
            transform.rotation = Quaternion.identity;
            GetComponentInChildren<MeshRenderer>().material.color = ColorStart;
        }
    }
}
