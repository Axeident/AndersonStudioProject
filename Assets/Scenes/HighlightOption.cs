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

    public Color materialOriginal;
    public Color materialEnd;

    private bool isRocked;
    private float RotationStart;
    private float RotationEnding;

    // Start is called before the first frame update
    void Start()
    {
        hasBeenHeld = 0f;

        if(shakeSelection)
        {
            RotationStart = 0.0f;
            RotationEnding = 15.0f;
        }

        holdTime = GetComponentInParent<TriggerRelocate>().activateTimer;
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
                GetComponent<MeshRenderer>().material.color = Color.Lerp(materialOriginal, materialEnd, lerpProgress);
            }

            startSelection = false;
        }
        else
        {
            hasBeenHeld = 0f;
            transform.rotation = Quaternion.identity;
            GetComponent<MeshRenderer>().material.color = materialOriginal;
        }
    }
}
