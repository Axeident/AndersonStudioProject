using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WeAreDone : MonoBehaviour
{
    public float HowLongTilStart;
    public GameObject menus;
    private float makeTime;
    private bool isMoving = false;
    // Start is called before the first frame update
    
    void Awake()
    {
        makeTime = 0f;
        isMoving = true;
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
                menus.SetActive(true);
            }
        }
        else
            makeTime = 0f;
    }
}
