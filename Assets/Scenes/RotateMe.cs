using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RotateMe : MonoBehaviour
{
    public float RotateSpeed;

    // Update is called once per frame
    void Update()
    {
        transform.Rotate(0, 45 * Time.deltaTime * RotateSpeed, 0);
    }
}
